Return-Path: <bpf+bounces-41348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4089995EA2
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 06:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA21F1C2237A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E87514A611;
	Wed,  9 Oct 2024 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhOwqdaK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD602F46
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728448645; cv=none; b=H1m1pZsAubRCTnkISpcHSWx/IvaLp4GQS9W/kiTT0bh5WhJwr+x47OJXepItDm4Zm4jftld0Muh0ul0xHq+0mJ8vAgi6a/IbZFkMFLb7TpTuFgmWnPYj0HvtTMa+91IXy+5WJwdizKtTXWtEROJcZ4zRtQ+LnF7boj6Ck0NCg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728448645; c=relaxed/simple;
	bh=5a/kqpyhf/9blW11CXEDirOvElZVP4ec27T673tn07E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ad7LIcBT5MPQlNEchZmaVdBPog6+dK5qDN6FLTVjgGBpY0OfijDjxVfsMwtjFb5O7blwbT2OVBQoWvkpfddFVzEshOtvY1fM09P/JElJMe96W/dcBwf+YiEsO0IPz4vy4Nip8fZuc9F2aFuQiuyNQswWRrWq6Rg63d3sTxNmBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhOwqdaK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e01eff831so2178698b3a.2
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 21:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728448643; x=1729053443; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZrYYzVZh/7kyt6exzI4kodUS/sByTPk6C2LWg6EjT4=;
        b=GhOwqdaKnw2KXFu4O/kzYtDcTFwQ3yfmtVKha7qL3kiltceGkCBkJUASXqUAEeTheV
         cMvbZK7LB00XoNWP8OtoFbDUHriJFvgiDykYee4xZwKg6GWFUZR8a/DsE9G0of+qlbaW
         9jiAvh5kFm4dLOEvCU98da0J86kTBr549zJ3FGdFK2K3dRpvIIJi5nEJeih8jwsTxxk3
         OA1/JNWezWn58hd/DIgaHxI22ARD/HQxk9xsZFlhudiw9O0YD9taLBHSxGLCLS9vUF/N
         201hQcVJ71IsKFtho5d5AfOKdc6tzEU5Wh7CWl0/Z7pBukIBn2xO1krJ4dYn215Sf5/c
         nplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728448643; x=1729053443;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZrYYzVZh/7kyt6exzI4kodUS/sByTPk6C2LWg6EjT4=;
        b=oUlVyOxcBDTwCB0zGjbhqZqAMvbdLh5B9FkLd6+1N5mjqxShF+pmRNtLQSIJsaH2nU
         RpAPGTSLA3xBjCMOqjGTqeqat4RFpF/A4VS5DwkMAvROcg/0lRixvpUWdCqB9a+WLUcJ
         M1pWS2bS48AlLwosAUYO3VI/Ok7jVpDgshIwfKRRuzQ4jmtjKdtF3RAUu6c3QAKKkDlQ
         kVXHuj+idQTQF7kwQrRT0LAEOvLfIsGoC8mXGQQlHV7yy6QpbBusS6ZV/G5jpX4a5FfE
         Umbq0XWd8Sx5y9vownKz0RCKq+PpnQDlWi9fZGiKrYlLthC/tL1UpszGv8YZj61Wn616
         F3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWmptu8oc86PkBxHEnpOJsyuPRVPwpgssJ4dQI10irVvAp7DmpYjFfl5jW9U7RW6PqjrUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBn5z8WoUfTx4zJclh1u2Y2M6kRamREA2BDNzY6vhrUPPe0plo
	HYs2Fl1a7OPvQDLCOtY8xHgc3pz5zKA2JScGp3kNVlb75ZdG11DM
X-Google-Smtp-Source: AGHT+IGApdkx0tSa3qzsYgLwdHeWU2ZdxDfJCMoVrRDGmHK/pBPHDrrzjd38sVkjBWgeSzM0TDwSlA==
X-Received: by 2002:a05:6a00:928a:b0:71d:e93e:f542 with SMTP id d2e1a72fcca58-71e1dbb7c5cmr2116863b3a.21.1728448643049;
        Tue, 08 Oct 2024 21:37:23 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d32fsm6893789b3a.217.2024.10.08.21.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:37:22 -0700 (PDT)
Message-ID: <fe9c1ce8f015b8faf5fe33c027485dcbef8d7905.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/3] selftests/bpf: Add a test case to
 confirm a tailcall infinite loop issue has been prevented
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com,  lkp@intel.com
Date: Tue, 08 Oct 2024 21:37:17 -0700
In-Reply-To: <20241008161333.33469-3-leon.hwang@linux.dev>
References: <20241008161333.33469-1-leon.hwang@linux.dev>
	 <20241008161333.33469-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:
> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
> 335/26  tailcalls/tailcall_bpf2bpf_freplace:OK
> 335     tailcalls:OK
> Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED

Nit: commit message would be more useful with a small description of
     the added test.

>=20
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


