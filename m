Return-Path: <bpf+bounces-35129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDF937E3A
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C101C21159
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 23:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D361494CD;
	Fri, 19 Jul 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mww3TWcR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517F145A12
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433140; cv=none; b=KuQSpUKJlJHGdTVvYxGZXe5lVuFGTN51wQr7XpwponKQeKAoO5G0kXGTrYJzzewogLWe8I2W0pNxAwvfNGAQm161zu4dBPLzGQ04uS++Xe2AVubAv5bSbMY9kxd+1lRZ6L4p6u6CrR6M9LV+oCDLEHCORnHTAtXQcKLVd6SNnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433140; c=relaxed/simple;
	bh=6lhsaLLgM5cm4c9RgYwjDEi1FldHxb1W24+7I48tCBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cEn5vSdCDFL8A/KocM23qWGp8T1duuj5asaK7tN9DHE7Cpi5wYDf1uAnuqcnO/zDXrGfby16JZieXowtUST4W3cbVF17PDJOekrHN4wjfqtKCpmWYVEio2NT/JZoY1/w97hqn3mOQUlo8Ch1GeweMn9rLYQH9/93K0cwk8z8tf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mww3TWcR; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d9c487b2b5so1574493b6e.3
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721433135; x=1722037935; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLMRq0BeHe04/vDnMTwU3JO63B7aVCSBz2NTr/ljS28=;
        b=mww3TWcRZmpzhgUp6+mNzY7TUnHuoObnRSKoxpfujJQiaGpgbrpXhzf2OkxrT/S61l
         nbLWZdMtrMwycTbfNIvsUN32/cO6iFNXV4S/D2/vLFMKna65qmx7ZP4d1kd8Lww5TbME
         GiVeZmNwEcNQlVx8vQl3v9qyH+qkrWuh8YNzlURAWZjiX3HpUcksFPiNDh8nbteOFn7C
         VSWyw31gbUtjsEh6UQ/fO63BwHWqUw9bpVSjKgKrIgMRioxLuvGfFLGuuyZ1q0WNE4UW
         cEwIJWn7zhHSRKAaq2N2aYJdlpTk1jxuygu/vcGBTERnE4A7PadnVOKc0FIue5G6r35l
         zD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433135; x=1722037935;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLMRq0BeHe04/vDnMTwU3JO63B7aVCSBz2NTr/ljS28=;
        b=Hdxjr5CPB1h/izq5eUlcmxFxyW3gXCbxlXaVhXa1wLfINLW7t5C96oItVksEKsNgMc
         gdqNXLwPLPmhDLMfRbwryZzhBwUZLQTyyvrfhD//HzI/2Aqoxw/UpppEirdyB43QOq4H
         gTUcuFpr32BYE/DTmXyyw/fP6mqkJT+plnRgaZiZVej8z85/n27xPckDiz7rlJKel18u
         6O/iGgArwyWXjPgFJCYlfOS7Z/tyXapsoUMNSqAEwnmQiqPVuPuJLODnjMv6goxDxLdY
         RZ3fupwTCQ4V/aiwSDYnV+rFGqypGe+U9gYDUvBJ7ERxcOxTm3cveQe8OnGWcbcmZlYI
         2EHw==
X-Gm-Message-State: AOJu0YygfMD9VUGJmZH6Tc/EpwFFZpaKLmHXuRa+VZrIreuIYfgSYEsG
	42GdU3bi7yC02HjQQg5ETQGVr/1TyLntRhyro/isGILGgn4TduAnltX52VD1JLU=
X-Google-Smtp-Source: AGHT+IEW3np/yxalaaiZnbURD2smeNTCZh5390jnnPkBLuTFr9lchJKGUu/KzBeaLrvOC30FckSnKg==
X-Received: by 2002:a05:6808:1521:b0:3da:a6ce:f02c with SMTP id 5614622812f47-3dae5ff8232mr1649816b6e.20.1721433134745;
        Fri, 19 Jul 2024 16:52:14 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:739a:b665:7f57:d340])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae09cef7asm491500b6e.42.2024.07.19.16.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 16:52:14 -0700 (PDT)
Date: Fri, 19 Jul 2024 18:52:12 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: pass btf object id in bpf_map_info.
Message-ID: <cc550614-780a-4df3-bded-b3d57036a5fb@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kui-Feng Lee,

Commit 1338b9334658 ("bpf: pass btf object id in bpf_map_info.") from
Jan 19, 2024 (linux-next), leads to the following Smatch static
checker warning:

	./kernel/bpf/syscall.c:4903 bpf_map_get_info_by_fd()
	error: we previously assumed 'map->btf' could be null (see line 4896)

./kernel/bpf/syscall.c
    4871 static int bpf_map_get_info_by_fd(struct file *file,
    4872                                   struct bpf_map *map,
    4873                                   const union bpf_attr *attr,
    4874                                   union bpf_attr __user *uattr)
    4875 {
    4876         struct bpf_map_info __user *uinfo = u64_to_user_ptr(attr->info.info);
    4877         struct bpf_map_info info;
    4878         u32 info_len = attr->info.info_len;
    4879         int err;
    4880 
    4881         err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
    4882         if (err)
    4883                 return err;
    4884         info_len = min_t(u32, sizeof(info), info_len);
    4885 
    4886         memset(&info, 0, sizeof(info));
    4887         info.type = map->map_type;
    4888         info.id = map->id;
    4889         info.key_size = map->key_size;
    4890         info.value_size = map->value_size;
    4891         info.max_entries = map->max_entries;
    4892         info.map_flags = map->map_flags;
    4893         info.map_extra = map->map_extra;
    4894         memcpy(info.name, map->name, sizeof(map->name));
    4895 
    4896         if (map->btf) {
                     ^^^^^^^^
map->btf can be NULL

    4897                 info.btf_id = btf_obj_id(map->btf);
    4898                 info.btf_key_type_id = map->btf_key_type_id;
    4899                 info.btf_value_type_id = map->btf_value_type_id;
    4900         }
    4901         info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
    4902         if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
--> 4903                 bpf_map_struct_ops_info_fill(&info, map);
                                                             ^^^
Unchecked dereference inside this function.  Potentially for BPF_MAP_TYPE_STRUCT_OPS
it can't be NULL, I haven't reviewed the callers.  Could be a false positive.

    4904 
    4905         if (bpf_map_is_offloaded(map)) {
    4906                 err = bpf_map_offload_info_fill(&info, map);
    4907                 if (err)
    4908                         return err;
    4909         }
    4910 
    4911         if (copy_to_user(uinfo, &info, info_len) ||
    4912             put_user(info_len, &uattr->info.info_len))
    4913                 return -EFAULT;
    4914 
    4915         return 0;
    4916 }

regards,
dan carpenter

