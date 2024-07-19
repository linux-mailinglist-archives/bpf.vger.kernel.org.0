Return-Path: <bpf+bounces-35131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F9937E4D
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7830D1F21C4D
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 23:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FB714884D;
	Fri, 19 Jul 2024 23:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bANEZ2y0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941A3C39
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433513; cv=none; b=MEzuoFlzNmwV5Y0B19gBFgZLWiI8qu46Pkc4WkAD+04OkcKdgNQ2oAypyJHmeQdMx5U3WwKioS4s0iTD36S3CLSKwV2YBacouKsq6xfgWgZbScKqIXMWFkii2wKRA7FMdDtXFjHm3TYnK2rl+UVU4aAwHuGIV5zIDTyBb6h4u2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433513; c=relaxed/simple;
	bh=L2+pHtLW63mRxBahZo/yw3jBH/2PrvaJ4OPBFuPQ3H0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fin9nvKbFqbD/k3LWp1t7JtZ9FjwVg+CiDmcV/1JT0fkuwW80DzTyroMOzv8PhTtjYUYLFISUl4fCTOiHtOnVnMVPFvtUTEEgiM/LYUAqb4DUsdCS8ucl+kwWuoqwyGd4WJz/ynKFSAi18EUITRdBqlVCnqZX+zLy82Zg+CYmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bANEZ2y0; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-260fcd728feso1043568fac.3
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721433509; x=1722038309; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtTFU+vqu2Idvp/EO8ohAWy99lmxVNUQ9Rb/RTp2McE=;
        b=bANEZ2y0gy4MqTopN55jIdi6hUdnDhbjZR2qq8Cd5YB/83VR1++pG7WjXnjNVvZ44y
         97UN5k13A9ku67MJPmu3x8mHAA+ag3jFwFpSIIut86OHed/uHQhjHDqIRs/4Rxo4+j0b
         pN7xzWqHPUT8ceB7DhJwpMlZTOOKkAd0QWYCs95GzsWcM+CzkOxTQ5I3NnPxUEfiSmJn
         ezJna70XclFB+85S6NBjRUktXIvHku1I+DN8ftOapYByT0a5ve4bgHMyxh2EvMh2kLC4
         PaLG7vAvetITPYm6CgDoSlb5oxKMxnEkQ9093bTBuxzNE2zCpFQnkIH8+uQHfmHkqjH3
         GH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433509; x=1722038309;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtTFU+vqu2Idvp/EO8ohAWy99lmxVNUQ9Rb/RTp2McE=;
        b=A/6TTP/fHlMPnEyUve1pi0guQybm5L3T7Uqv6ZlIH8fwTMPil4DwxBaxndCtBYFzKc
         UU0zFIxA3cAol1ABxei5tMaqE6m4S6LPd/0v/QYTUG6sZB647CedrT6rDCx/Y6Z5drV5
         jTM1MusuPYbJ7Efw3lT/KPp0c8IVi7n7+7rccDSaZX4iYHrtyAFjGmlH+O1qbECwjvap
         tY4AiNSbDYN9T9+lCoeDOCGu0DDvz4S2/mil8c2aih+GleSzohd2kCmvbZF1mXsGSBCa
         gQVRFV5uK8C9jS+MwQBodUApg2dlYKff/ODLHvgUS6s8Y8FQEvjInVtEko0iQmiNA7gg
         eU1w==
X-Gm-Message-State: AOJu0YxL/7yMWOc9Bll3aUZipSiu6cdT68oX5JFRmiZ6IpYVdarVvpda
	9itc7MybR6QQKTsZ7w5iIY7JOwhaYdsWhFUhabHR+IwFWBYVKdRMvNxj1XvyPNQ=
X-Google-Smtp-Source: AGHT+IFwMFC7hfaB1HtleVNbk/qZN6cxVnB/vEoZHUVW8buLm44FwRTyCyI9g/KObm789Gyk5rmSYQ==
X-Received: by 2002:a05:6870:a10d:b0:261:362:d738 with SMTP id 586e51a60fabf-263ab31e90dmr58550fac.18.1721433509624;
        Fri, 19 Jul 2024 16:58:29 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:739a:b665:7f57:d340])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2610c7cf1fdsm537568fac.28.2024.07.19.16.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 16:58:28 -0700 (PDT)
Date: Fri, 19 Jul 2024 18:58:26 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Martin KaFai Lau <kafai@fb.com>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: btf: Check members of struct/union
Message-ID: <f96117da-57df-4778-8fe7-b433c1b755e6@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Martin KaFai Lau,

Commit 179cde8cef7e ("bpf: btf: Check members of struct/union") from
Apr 18, 2018 (linux-next), leads to the following Smatch static
checker warning:

	./kernel/bpf/btf.c:2893 btf_array_check_member()
	error: uninitialized symbol 'array_size'.

./kernel/bpf/btf.c
    2873 static int btf_array_check_member(struct btf_verifier_env *env,
    2874                                   const struct btf_type *struct_type,
    2875                                   const struct btf_member *member,
    2876                                   const struct btf_type *member_type)
    2877 {
    2878         u32 struct_bits_off = member->offset;
    2879         u32 struct_size, bytes_offset;
    2880         u32 array_type_id, array_size;
    2881         struct btf *btf = env->btf;
    2882 
    2883         if (BITS_PER_BYTE_MASKED(struct_bits_off)) {
    2884                 btf_verifier_log_member(env, struct_type, member,
    2885                                         "Member is not byte aligned");
    2886                 return -EINVAL;
    2887         }
    2888 
    2889         array_type_id = member->type;
    2890         btf_type_id_size(btf, &array_type_id, &array_size);

Potentially this is a false positive and btf_type_id_size() can't fail.  But
we're in a check function so intuitively, it feels like we should check for
errors.

Anyway, just let me know if it's a false positive.  These warnings are a one
time thing but it's nice to have the information on lore in case someone is
curious.

    2891         struct_size = struct_type->size;
    2892         bytes_offset = BITS_ROUNDDOWN_BYTES(struct_bits_off);
--> 2893         if (struct_size - bytes_offset < array_size) {
    2894                 btf_verifier_log_member(env, struct_type, member,
    2895                                         "Member exceeds struct_size");
    2896                 return -EINVAL;
    2897         }
    2898 
    2899         return 0;
    2900 }

regards,
dan carpenter

