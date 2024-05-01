Return-Path: <bpf+bounces-28371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094208B8D9B
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1646DB21EF7
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF32212FB39;
	Wed,  1 May 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P1YcI/de"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD79502A9
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579359; cv=none; b=vB10aZibS9NHmfK3WyFwlbu1SD1l/rrapA7mmx2IeqBPcjsf6nkeUodNser1/Wrwpwk1EmtM/92jjEUeNEiuGfl3kPkjSLMBD1yrWuJ5/eNNdDrJH16OCAvHeXWyfVGQb2Qso3Qp7QAl2SKHd9emrFIemz5duHfomVFI0NwOpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579359; c=relaxed/simple;
	bh=GIg0qqxY8IGXzYWeoYuXFScFx99CyexVXC/du3NFi4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mErNHrtpyMvHdlzmGrzOMkV/dd9iXWMDKAhcmykF+Hsm+gYAE+PzWCu9wzEbql+4vlUzwQi32yzKQTTZr3/i/JKx2cic9m1OflfABX/WqX5Wspfymqkx4P4Mp2oZvaqCVH16MBV5jXcF8pi5wTQkG/bZ6ILNSIQVVoJx716zezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P1YcI/de; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-615019cd427so55280237b3.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714579357; x=1715184157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuTSwyg4Duor6hNxagd4NLjWGY2C1Kh2NptH/U7fxFA=;
        b=P1YcI/dem4TRC4j5+FEOVVmy1k7Gt8gMWaFa6DR/9SVJeRjicoNaEQCQVMzn1oNHBD
         z0Dp8S6oBaPuxUEkhALGNvzdBHH0JrqKliWUoscGUAzGRGUp/e081f7qNDokqODU7uv/
         kYmCgiUJ/pMKp8EMeba/cDuDhEmbM7IcK2Ijk1NaflsxBqhQkSSkOy4QsFQjIJKl9zzr
         yz9A6wXnlqR84x+ayJ3AJ5YbdrEovDtmmHXOfI8OH1HdK17+3dI2FZLiUlaEszLexg9w
         ITtukCHBAu5jgQMhxyIDEIfiHcRciLu3OuHmC5ZMHQXm87dEKE/YAtz77jH7reGs1ZXa
         o56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579357; x=1715184157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuTSwyg4Duor6hNxagd4NLjWGY2C1Kh2NptH/U7fxFA=;
        b=O31hH+YJKu4OxhWlKpD9s2fUSXVnOB/Ik3hUeFFY5YorBIGJjCHPWsGADTzhmerUmR
         Evl+KuSoGWSLP7KBqaQfTfQihLGtpDEer6YjNYvE9JrGQBHmFi4TdgDVG/7Z96fhVuSP
         id3fsEgYvlr1qb97Kpu0kGPlvDuzrXak4hXIIR3zM2tiudJ9DmDRV0we2BqmGhEvL/d1
         U1yDZEZqwfH4QssI7kMiY/h8rYYcAzuvzxTGlFBhmrtXHJCDxEYubCZFYQlXuf/+xlx0
         odrvyMg6iHOQLdTwoUDaKgi2vwlonmJ9DC6XavsDmabF1PRo5hrWMAgjF4jyjNLTc7my
         uhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ydjkuCvSZAFve7v2VoCoV4E5+UGegO4CVkKGJbnBKVK7Vs5DL0YELD2hp48hQljhB5nWuJDTCwPFtKA6G647Nk+t
X-Gm-Message-State: AOJu0YyIKpwe9xQuYDe6lluXtUhRm/aB27FMbWpDZceYIcjD7/DWXlNi
	P84uz0BKFyZ4IhKGrBSblLlo20GphFr4sEQ3klYERWici4wH3/7Ot4mTGNhJ5YVUD85yhhcaL3k
	5K7ByLcJN1b8u+12LgeyW3ljq+8kNY48/mR5j
X-Google-Smtp-Source: AGHT+IH43KKvgq5pfK+zLJrg5zNUpKsT1cly8y7M41qu+UjyduRLJHzscgOqbVjTe8DbGTiF22UP57FY9wim6c+i6ZY=
X-Received: by 2002:a05:690c:3586:b0:61a:edf1:da55 with SMTP id
 fr6-20020a05690c358600b0061aedf1da55mr2907562ywb.47.1714579356786; Wed, 01
 May 2024 09:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429114636.123395-1-fuzhen5@huawei.com>
In-Reply-To: <20240429114636.123395-1-fuzhen5@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 May 2024 12:02:25 -0400
Message-ID: <CAHC9VhTCFOCE0E-en3HnNkPVRumzWRPcrJMF-=dxke53dOv1Gg@mail.gmail.com>
Subject: Re: [PATCH -next] lsm: fix default return value for inode_set(remove)xattr
To: felix <fuzhen5@huawei.com>, linux-security-module@vger.kernel.org
Cc: casey@schaufler-ca.com, roberto.sassu@huawei.com, stefanb@linux.ibm.com, 
	zohar@linux.ibm.com, kamrankhadijadj@gmail.com, andrii@kernel.org, 
	omosnace@redhat.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	xiujianfeng@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 7:47=E2=80=AFAM felix <fuzhen5@huawei.com> wrote:
>
> From: Felix Fu <fuzhen5@huawei.com>
>
> The return value of security_inode_set(remove)xattr should
> be 1. If it return 0, cap_inode_setxattr would not be
> executed when no lsm exist, which is not what we expected,
> any user could set some security.* xattr for a file.
>
> Before commit 260017f31a8c ("lsm: use default hook return
> value in call_int_hook()") was approved, this issue would
> still happened when lsm only include bpf, because bpf_lsm_
> inode_setxattr return 0 by default which cause cap_inode_set
> xattr to be not executed.
>
> Fixes: 260017f31a8c ("lsm: use default hook return value in call_int_hook=
()")
> Signed-off-by: Felix Fu <fuzhen5@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Adding the LSM list as that is the important list for this patch.  I'm
also just realizing we don't include lsm_hook_defs.h in the LSM
MAINTAINERS entry, I'll submit a patch for that shortly.

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index f804b76cde44..9c768b954264 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -144,14 +144,14 @@ LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *i=
dmap, struct dentry *dentry,
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap=
,
>          struct dentry *dentry, int ia_valid)
>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
> -LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
> +LSM_HOOK(int, 1, inode_setxattr, struct mnt_idmap *idmap,
>          struct dentry *dentry, const char *name, const void *value,
>          size_t size, int flags)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
>          const char *name, const void *value, size_t size, int flags)
>  LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name=
)
>  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> -LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> +LSM_HOOK(int, 1, inode_removexattr, struct mnt_idmap *idmap,
>          struct dentry *dentry, const char *name)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dent=
ry,
>          const char *name)
> --
> 2.34.1

--=20
paul-moore.com

