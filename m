Return-Path: <bpf+bounces-42252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1EA9A1611
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 01:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C495280E0C
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6211D414B;
	Wed, 16 Oct 2024 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njHg3KSo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734E170A3E
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120637; cv=none; b=YRITwgKNxgOlGRlyD9PnpuLxpldPnrp7JHTlfHcYfEdw4FZFzWAkeoZXh+6BrZ9j1QRt9WNhYeF/1qDe/dXSEbV2BnRSimTgBKRq8bh9vwEL2j623wmqTATgZpFLgoNykj9AN2UgP5GOkLbPOFJz78SDaDWnR0rS1GmKeWkF5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120637; c=relaxed/simple;
	bh=xZVytYTOAq6STNDhKuN3i+WZpOCiyA61EH57ycwiHVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKwGIAWLOHvQjZZLNrTZlwe9Wp0SzJHierznhKx65qt/sIqMObpya0184dlYNg0yirFLK6utnkIMn34pDpAnONEX1V5JRkFknL2TJsZH/nN/VlfPA4I68n2k2jwomC7/EoAyDZ0zBJhN8zibVXySnlTnkbEYfbaIQffW+vxbhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njHg3KSo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2e23f2931so293400a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729120636; x=1729725436; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxHmJR1YCq9v3DTNptEvaqi0kXEUAdmShYOgfzeJVBE=;
        b=njHg3KSoMl5Nwm6Y2V/VaRWKWSsn+osrk4UDKCYtIY9M3DjsfbTTq/MARQyagYj5VE
         Y5rC8Jkx5yjvCsLz9DFcflsXmVNV4bMDQwnfClXMIL56KegVUcfEMoAU8G85CftypbIj
         OaUVJIstKiwU4eLMkrUZoNOIRAu/Xtu37NiNKeUtstPzVvAD/9BFfUO8dYHCa4MP5IhZ
         jy8PIt6Jb0flQZHMV6hk5AXRPYRWeo9UfORy6IjpalSIn7M7NU80Ll+S2q7q80zsnHlx
         8ky6yRAyZcf+bnW04caoERc2VmlG2N+7nEALimq6MpO3JqvH2NjPjZlMy8cKI1tQvuJc
         hkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729120636; x=1729725436;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxHmJR1YCq9v3DTNptEvaqi0kXEUAdmShYOgfzeJVBE=;
        b=KDezxUskSbdJmhJV0bHeOjtYijAa2vbriuLSwxwlA9wUd7ckBVWlKWA2CUryQcgfIo
         8nU8WjGjRqYMFT9P/SJl+oeoyMFpJ9bumoQqO+h5Wdm8K629qcAMcr9nRKflmwrmdaOf
         0k24DeQwzV5CXAa4xJ6138sdUo4oaqktuMTef/yzZQXXKeginCPeYGaJxULO2h9NVc5g
         R6kBi0PHcU/kwEHaBE4+7PY7I1fZwp8HMSyxeiEH/V3D6Tgre8BHstEtcRBGssFzwgGd
         kLloxnm30SoI8B8tb43nAB3jvDRxGX7c0uMHENL/KInQ7k537S04Rl+dIDqQyiXiPRY4
         FUFw==
X-Forwarded-Encrypted: i=1; AJvYcCU4D7MZLBCLEYI6LIt6Uq6qfDDqz0N6BBwgw9w8S/zM+hisXrj85JwHgzGCSSHT/JKSwmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCiTilVeoT8uk2bo0FRWi9rwFjAdWiLpmNVxKUG9YVYeyYED0
	ot4ettO+yDj2Tdon6TnsGzSML99zJFLdE3U61KIEpaZ+Y72rpTu6
X-Google-Smtp-Source: AGHT+IGFGDmieA1Mjv4KA6ySg1b3K8nalh/AM8iLlGzm2vWwly/fiWXe7CphnOIPm1WkSw1mDcgQHg==
X-Received: by 2002:a17:90a:b398:b0:2e2:e534:cf6e with SMTP id 98e67ed59e1d1-2e3152ea999mr22017954a91.24.1729120635522;
        Wed, 16 Oct 2024 16:17:15 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3b1dad760sm2080374a91.0.2024.10.16.16.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 16:17:15 -0700 (PDT)
Message-ID: <7919c04f566896f293f6f6b3cc988bb6b5a5c95a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Allow building with extra
 flags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Date: Wed, 16 Oct 2024 16:17:10 -0700
In-Reply-To: <ea7b96907258a47e071028b8d9ca21eca7ab9050.1728975031.git.vmalik@redhat.com>
References: <cover.1728975031.git.vmalik@redhat.com>
	 <ea7b96907258a47e071028b8d9ca21eca7ab9050.1728975031.git.vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-15 at 08:54 +0200, Viktor Malik wrote:

Tried this, seems to work as expected, but see below.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -388,8 +394,8 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Make=
file)		       \
>  	   $(APIDIR)/linux/bpf.h					       \
>  	   | $(BUILD_DIR)/libbpf
>  	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=3D$(BUILD_DIR)/libbpf=
/ \
> -		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
> -		    EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS)'			       \
> +		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
> +		    EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)'	       \
>  		    DESTDIR=3D$(SCRATCH_DIR) prefix=3D all install_headers
> =20
>  ifneq ($(BPFOBJ),$(HOST_BPFOBJ))

Note, that there is also the following code just below this hunk:

ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
		$(APIDIR)/linux/bpf.h					       \
		| $(HOST_BUILD_DIR)/libbpf
	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
		    EXTRA_CFLAGS=3D'-g $(OPT_FLAGS)' ARCH=3D CROSS_COMPILE=3D	       \
                    ^^^^^^^^^^^^
                    needs an update?
                   =20
		    OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/			       \
		    CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"			       \
		    DESTDIR=3D$(HOST_SCRATCH_DIR)/ prefix=3D all install_headers
endif



