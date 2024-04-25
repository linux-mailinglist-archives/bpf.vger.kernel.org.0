Return-Path: <bpf+bounces-27768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA48B17E9
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 02:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6C71C22189
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC3816;
	Thu, 25 Apr 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnE37A0W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF236E
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714004288; cv=none; b=LIf8TQ+Q9CEDbF1eGftvDlsg2V6MF/ux06aJ7AitsHMfsn2a0lJ1Eb6b3nK3wDOq1Hw5KQ8Olet3Q3UeOAmQysY2Irx40J7gF+gJzuDzy9nXQZ45iQzAs/o+p3i5n0ryoaegW0yDGjQQBT0qy1aLFreMwlMJaxUNGwbBa1Tshjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714004288; c=relaxed/simple;
	bh=m1FweiqXteEpIp1eRjGDKDB/rHzAN+QcBWI+RXSSbGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/t4JWlG3f4TZymm6lnbZ2fu4Vxip2U9v3wTpzicdN1EtBuqngjiobiVHt53jHW9Y/y0s2Nb+CkMd+d9XqcU9/Up1KGMz5J++3Vfj7FBqVXaACUEUnbIJaqNLQA9q4w0+ydnPCvREJVynVTmEMPvxMRQLE+tqUmpP/DPJ97Eqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnE37A0W; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed01c63657so441859b3a.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714004286; x=1714609086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N16xeguh7ALZqvNHnnvPx+3YJeDU64GdYsKGiJNOH3o=;
        b=UnE37A0WSNIeb89jwp6hxo8nvFIe8AU9rLMGD4RATP9YrIXFHioeOmqjmkxq2LRkm0
         6fT/7CeUhVcDuN7fhI0iTLiIXoKTU2p18QnocE/8J06F8KfrYO0dzti16lIQOpmrqDCR
         ECcnAEASTBJ0RAmT9cxljSk9Re1yPFdnPtsx0MdLbV1bbJ9DCYC3eZu9DAOfNJHdCX6b
         wkqdl4luFqYZjwRybtoEYpnKIjbD1Vk84V4lMlvmRI4wXMoXLx4JOb3vRZO5f+Vt4MuI
         CUvGO4D3oG0fociUkjD53gKwOW1fHupL2oO70RD4BClmxDOTIssMuso18cEJgsiDmqV6
         Z+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714004286; x=1714609086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N16xeguh7ALZqvNHnnvPx+3YJeDU64GdYsKGiJNOH3o=;
        b=JgRadJlzsdK8sR+tWJbqJShTVA8Nc4K/PClx9gb7aE43BtRQnf2KGZpY0zMj/M53IT
         PMRRFdzoIvkTXBck7UPM0uetn9TsawGoTpOpnwGJaeuU7VJqGoffNMIXv2VkjxgjZ8a9
         W0QBC42VybC9MMlXnVbNI2sSWG/oXy6ji7PLBsSn4JmxeO8Jw+cGV/kAjos4kr283MpO
         6osIA3G/L5TBKR6HR7Agd8Vahu5LkT5kaVKU1x56XgKNOV9nHc3TWKwAecJl0/+4t+QC
         WVDwx6dFZMj1kfeet/0dSjD9pj0G+wnE4pKSecS9Q5fm6JHeMG0Z+8TkAux4Egm0NnZP
         pm0w==
X-Forwarded-Encrypted: i=1; AJvYcCUlJtkCRcuoPUHexT/Y5/pg0jDnXeOQN+BlJqNqHeh5z16fs70DlBjAmJkU3WBRi3Cq7WzNRoJDF3SwdDeHJFmMtNED
X-Gm-Message-State: AOJu0YyDISOyMJWEwg0V05MNSY1XB0/cJozGN/HPhs9F/T0I55fzPHzH
	qYmucCR09ilkZPUrq5GVCxu22xrgmu6BYUDXXGxjZNo4MmQ6d2QZwvYyre6zlI4WzIp21MtbXBz
	6eq0r5uPGHcLdpyNxPOpKblYE2N0=
X-Google-Smtp-Source: AGHT+IF05QYclO+b7ZdA1zth054wOLQSfzr/VomTFYSDseJwDvV+xDIEcPdMQPQ3JzUwzig+9l7rEEb/Ku1qxxLEhvg=
X-Received: by 2002:a05:6a20:5520:b0:1ad:878:5006 with SMTP id
 ko32-20020a056a20552000b001ad08785006mr3838335pzb.14.1714004286351; Wed, 24
 Apr 2024 17:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417002513.1534535-1-thinker.li@gmail.com>
 <20240417002513.1534535-2-thinker.li@gmail.com> <8dadfcc9-1f6a-4b93-951b-548e4560ce5a@linux.dev>
 <0326d150-6b43-465c-ba43-7e7033b13408@gmail.com> <70bf97a6-19d8-4a26-8879-17db7c44a2cc@gmail.com>
 <54f32ade-ec17-4c35-b993-44907111e7ca@linux.dev> <696735aa-59e1-4750-814e-216b85fe934b@gmail.com>
 <68ae7e9c-3bd7-4370-ab06-6e787ca27340@linux.dev>
In-Reply-To: <68ae7e9c-3bd7-4370-ab06-6e787ca27340@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Apr 2024 17:17:54 -0700
Message-ID: <CAEf4BzbOgGVVcWhydbgSGAeDcPjuumMxVZgU_ak4JUFns_YwRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned
 path of a struct_osp link.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, andrii@kernel.org, 
	kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:29=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 4/23/24 10:16 AM, Kui-Feng Lee wrote:
> >
> >
> > On 4/22/24 16:43, Martin KaFai Lau wrote:
> >> On 4/22/24 10:30 AM, Kui-Feng Lee wrote:
> >>>
> >>>
> >>> On 4/22/24 10:12, Kui-Feng Lee wrote:
> >>>>
> >>>>
> >>>> On 4/19/24 17:05, Martin KaFai Lau wrote:
> >>>>> On 4/16/24 5:25 PM, Kui-Feng Lee wrote:
> >>>>>> +int bpffs_struct_ops_link_open(struct inode *inode, struct file *=
filp)
> >>>>>> +{
> >>>>>> +    struct bpf_struct_ops_link *link =3D inode->i_private;
> >>>>>> +
> >>>>>> +    /* Paired with bpf_link_put_direct() in bpf_link_release(). *=
/
> >>>>>> +    bpf_link_inc(&link->link);
> >>>>>> +    filp->private_data =3D link;
> >>>>>> +    return 0;
> >>>>>> +}
> >>>>>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> >>>>>> index af5d2ffadd70..b020d761ab0a 100644
> >>>>>> --- a/kernel/bpf/inode.c
> >>>>>> +++ b/kernel/bpf/inode.c
> >>>>>> @@ -360,11 +360,16 @@ static int bpf_mkmap(struct dentry *dentry, =
umode_t
> >>>>>> mode, void *arg)
> >>>>>>   static int bpf_mklink(struct dentry *dentry, umode_t mode, void =
*arg)
> >>>>>>   {
> >>>>>> +    const struct file_operations *fops;
> >>>>>>       struct bpf_link *link =3D arg;
> >>>>>> -    return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
> >>>>>> -                 bpf_link_is_iter(link) ?
> >>>>>> -                 &bpf_iter_fops : &bpffs_obj_fops);
> >>>>>> +    if (bpf_link_is_iter(link))
> >>>>>> +        fops =3D &bpf_iter_fops;
> >>>>>> +    else if (link->type =3D=3D BPF_LINK_TYPE_STRUCT_OPS)
> >>>>>
> >>>>> Open a pinned link and then update should not be specific to struct=
_ops
> >>>>> link. e.g. should be useful to the cgroup link also?
> >>>>
> >>>> It could be. Here, I played safe in case it creates any unwanted sid=
e
> >>>> effect for links of unknown types.
> >>>
> >>> By the way, may I put it in a follow up patch if we want cgroup links=
?
> >>
> >> This does not feel right. It is not struct_ops specific.
> >>
> >> Before we dive in further, there is BPF_OBJ_GET which can get a fd of =
a pinned
> >> bpf obj (prog, map, and link). Take a look at bpf_link__open() in libb=
pf. Does
> >> it work for the use case that needs to update the link?
> >>
> > It should work.
> > So, this patch is not necessary. However, it is still a nice and
> > intuitive feature. WDYT?
>
> There is already BPF_OBJ_GET which works for all major bpf obj types (pro=
g, map,
> and link). Having open only works for link and only works for one link ty=
pe
> (struct_ops) is not very convincing.
>
> Beside, I am not sure how the file flags (e.g. rdonly...etc) should be ha=
ndled.
> I don't know enough in this area, so I will defer to others to comment in
> general the usefulness and the approach.
>
>

Didn't see this discussion before replying on the other patch. But I
agree with Martin, we already use the BPF_OBJ_GET method, and we don't
support directly open()'ing progs/maps, so I don't think we should do
this for links either.

pw-bot: cr

