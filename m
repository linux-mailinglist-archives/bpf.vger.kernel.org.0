Return-Path: <bpf+bounces-17949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6B881409A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 04:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA371F22D79
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B82105;
	Fri, 15 Dec 2023 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/CergD+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71DE1FBC
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3364ab04eb8so142719f8f.2
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 19:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702610612; x=1703215412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM3r5BteKCwvOglyCMSO9ZNaxJ9HlBVvZCQwYnLcbMw=;
        b=Y/CergD+FD681B5abkWapVdJ3697EM/dxJPkMCjzeAHGeMBhBiK2ajicOBrDDxBhav
         iPrzBddqTj2YypzxcBIzasboIXfn1+qpXEWuMgAni0l1HzhZLDzAn0Lvnm1JkAYUsthW
         sBqthpAvFScb1OgNs0e8Kd199v4SH8VpE/auTpgdy2ebzdFjPmmDGr5G7xTJ7vhhg0NH
         oRZWiXIAMlBiAgK9lad7V7DRY3SAoFyinvC07QfUethklUMEM0hGI9mPoq4El2ziTP6m
         8gt6C+rK1WP9WbK6CkJeWV3q7DsafeqEklzmdxBJxZxnpOkZ+Rm1wSTfqWdUGMDmkAPW
         rFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610612; x=1703215412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RM3r5BteKCwvOglyCMSO9ZNaxJ9HlBVvZCQwYnLcbMw=;
        b=Ow2yj7qDPcF5DZpBbBSGRooDCrn6oL3VkJqWih5jG+F123tUay5GoUGX+iP9nszm7W
         tBHPrgaR85Ie8hvlH3sP22J5+AHghjhZ6Lnaae96I52b8Mhh67+IlJ3p4eeedmhG1Fq6
         sqI2Nl0XuBf3PAlJkqadvuopywIa3fSGw01vhx1b38Uf29vfTrOoS/9dv9yhXlv4gYB7
         DTL16IxenqMwbVTfOLRNHVKgtIp04pJHg/AYrNiWY2NKETEix/Pf/j1Pud/MgQJFaq5+
         GiVN3LvvbFAZUs42alMPQTAMjY/dsQzIzh4tpJouP6SJQf1PKOcIfXb5UN1j9ZJb/aCz
         nQ3g==
X-Gm-Message-State: AOJu0Yxp9vQJLvrsYt0X2rw3v21jeUtzdljLC0iJ9rAucqIcGzs6ELt9
	roRdAat7iNYu0EVCSz9PmI8qu/OczJeOFvME+b0=
X-Google-Smtp-Source: AGHT+IHX9gH2vsZMAEqLvT/RElgSCeMPfyZaUmov4x4FZwlbtbjf/pNGTcl3dRw+fJkOhypQkA40jeT6W9cs9yARqQU=
X-Received: by 2002:adf:ff8d:0:b0:336:462a:dc16 with SMTP id
 j13-20020adfff8d000000b00336462adc16mr717491wrr.166.1702610611759; Thu, 14
 Dec 2023 19:23:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214043010.3458072-1-houtao@huaweicloud.com>
 <20231214043010.3458072-2-houtao@huaweicloud.com> <657a9f1ea1ff4_48672208f0@john.notmuch>
 <ba0e18ba-f6be-ceb9-412e-48e8e41cb5b6@huaweicloud.com> <CAADnVQK+C+9BVowRxESJhuH7BM+SWn2u_fTU2wjH0YuA-N9egw@mail.gmail.com>
 <657b545493a0b_511332086@john.notmuch>
In-Reply-To: <657b545493a0b_511332086@john.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 19:23:20 -0800
Message-ID: <CAADnVQJ6EmsOPqCtP2zJVNFDONhXx+KOnO=Pt6ho01vP_7ws0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
To: John Fastabend <john.fastabend@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, xingwei lee <xrivendell7@gmail.com>, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 11:15=E2=80=AFAM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Alexei Starovoitov wrote:
> > On Wed, Dec 13, 2023 at 11:31=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> > >
> > > Hi,
> > >
> > > On 12/14/2023 2:22 PM, John Fastabend wrote:
> > > > Hou Tao wrote:
> > > >> From: Hou Tao <houtao1@huawei.com>
> > > >>
> > > >> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
> > > >> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
> > > >> callbacks.
> > > >>
> > > >> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't =
need
> > > >> rcu-read-lock because array->ptrs must still be allocated. For
> > > >> bpf_fd_htab_map_update_elem(), htab_map_update_elem() only require=
s
> > > >> rcu-read-lock to be held to avoid the WARN_ON_ONCE(), so only use
> > > >> rcu_read_lock() during the invocation of htab_map_update_elem().
> > > >>
> > > >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > > >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > >> ---
> > > >>  kernel/bpf/hashtab.c | 6 ++++++
> > > >>  kernel/bpf/syscall.c | 4 ----
> > > >>  2 files changed, 6 insertions(+), 4 deletions(-)
> > > >>
> > > >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > > >> index 5b9146fa825f..ec3bdcc6a3cf 100644
> > > >> --- a/kernel/bpf/hashtab.c
> > > >> +++ b/kernel/bpf/hashtab.c
> > > >> @@ -2523,7 +2523,13 @@ int bpf_fd_htab_map_update_elem(struct bpf_=
map *map, struct file *map_file,
> > > >>      if (IS_ERR(ptr))
> > > >>              return PTR_ERR(ptr);
> > > >>
> > > >> +    /* The htab bucket lock is always held during update operatio=
ns in fd
> > > >> +     * htab map, and the following rcu_read_lock() is only used t=
o avoid
> > > >> +     * the WARN_ON_ONCE in htab_map_update_elem().
> > > >> +     */
>
> Ah ok but isn't this comment wrong because you do need rcu read lock to d=
o
> the walk with lookup_nulls_elem_raw where there is no lock being held? An=
d
> then the subsequent copy in place is fine because you do have a lock.

Ohh. You're correct.
Not sure what I was thinking.

Hou,
could you please send a follow up to undo my braino.

