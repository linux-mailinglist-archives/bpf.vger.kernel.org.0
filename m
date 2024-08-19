Return-Path: <bpf+bounces-37533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A237695741E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B6B251FE
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F921D54E6;
	Mon, 19 Aug 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtF2A3RF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1526AD3
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094370; cv=none; b=jddR4W7w3BcZcSc+8B5QSzO0rwCaQh62xU+j/Okzw3lERNzPatgQSUFKVKeJH66J7TPpSyafWFxR/C04ZTAoCT1xIFDq1my+Ccm8Y6NovYNkWaHI5iJBDk2q/BJUmSMo5lAlARXJfxZ+v0mcwkKLFkUsUZlnWX9yQLgaYeFIcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094370; c=relaxed/simple;
	bh=x6GnFcqfLriMSUYlFosyi4vREQXK0AxVjX74gMTIg+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eT2HgtSw8ce7Leg4vnHmMQzgLfz8KQ0qArvhq9oei7OWJ6Vct5Wo1YIG2UcSNzMHLN/9+h8WMtCxGA4mMR+qVeUGFAidX/w7So0tPiUMzghD0ba3R0P0PZCn5xH9HuldBtkx341j3SQuj8VRSfB+2pmPT8CWcqHs6pXomRX8xe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtF2A3RF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42819654737so36380415e9.1
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724094367; x=1724699167; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UEtwhiDLRyDYkOKHIKV2oClEzfiqKDNu1A7NXjK9I4=;
        b=rtF2A3RFhQPx99JugRcYB8yHOWnfqIUQpTZ09EMrFCDISz3g3TUUa/JXol8BUxOPH3
         NNA9G2A7urL9AXbQCRkFGPqAcDaCsqy27z9LAiFdIsb/r0MPFqmHC57lIbUw55FxSxGP
         yWat9ZWvT7U+RCy8dWbOhLRn661xs+nGzrom6ELhM7aBCv1wuPqxEzuhl2cafjQ4JDAd
         ef/RNpMKrtRNjq0lh9a8npJXoI39kOwnuVTnZrVAMIMAwFkzicry8qNPa6E3BwPJzOxw
         K8WQl8UwkYserkIaKpxB5Jk0X2MVS1wuuEnxj1FHG0L5aJAePyHi3V6ab9Xrv379ei+Q
         efwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094367; x=1724699167;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UEtwhiDLRyDYkOKHIKV2oClEzfiqKDNu1A7NXjK9I4=;
        b=a650/HQ7FNHdjEyywa5gVzElTOCNTdYghfmSaI8L49r8KH94+qCJR1Y/k/IygVsV+F
         Wv6abanw4y6NUBBxfPusdgLJ9NdnMRWynEZtHskcT1tErBVoDXTqAQrTzCw/c9f+v3Ww
         0JtoAgvyqCHJ/2yAoslA+YebOspt5LzJpLOPZnvR6yo8Kcwksj1YSb9OR6+fTZjkV8FR
         j2AQ4rnLEToP4orvobvUFpc5tJzQCuL9npaFycDZv8RkUaPRl4JdJKeOpgIBhfSBxyaF
         5odVdmZMNhG0nwnM9D6zlQAH3kW7MsjThJcr5Q+3UjVLBOVkTap/OFqw3Qnn/FQNFCFU
         l1JA==
X-Gm-Message-State: AOJu0YywXBekILFViaRLJ1JV1QUVH4Udnw2iaUNKWLrag53F412Le9Zo
	k3Dwfl2ksdoDREmGUjhZNrCl1Z6HOUa7z+R2FbLFDiM7mOYoWw8csBi0wByPEWw=
X-Google-Smtp-Source: AGHT+IG1Etc8UOD2bthAtuxpIsQuT4h8o2ir8tnTvxL5txe5jamTB0vJeRcjsHL3kkTXkK5xwtbjFA==
X-Received: by 2002:a5d:51c9:0:b0:360:9cf4:58ce with SMTP id ffacd0b85a97d-371946a44c7mr5808551f8f.46.1724094367018;
        Mon, 19 Aug 2024 12:06:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe2639sm6131910a12.12.2024.08.19.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:06:06 -0700 (PDT)
Date: Mon, 19 Aug 2024 22:06:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hou Tao <houtao1@huawei.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/bpf: Factor out get_xlated_program() helper
Message-ID: <1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Hou Tao,

This is a semi-automatic email about new static checker warnings.

Commit b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program()
helper") from Jan 5, 2024, leads to the following Smatch complaint:

    ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
    warn: variable dereferenced before check 'buf' (see line 454)

./tools/testing/selftests/bpf/testing_helpers.c
   453		*cnt = xlated_prog_len / buf_element_size;
   454		*buf = calloc(*cnt, buf_element_size);
   455		if (!buf) {
                     ^^^
This should be *buf.

   456			perror("can't allocate xlated program buffer");
   457			return -ENOMEM;

regards,
dan carpenter

