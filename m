Return-Path: <bpf+bounces-33117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F29175FF
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 04:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A3BAB22016
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 02:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0537E1BF3B;
	Wed, 26 Jun 2024 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc6gNA1V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4D29410
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367613; cv=none; b=ZrDIETt0mXnr1JvmP7H8rr4BFIYW7IpTc/4w76wU3rxU6hnf/2bZ9QvQjTtx81dYLy2EGoC9LFQRasGZe0LPDDm8OWtBgzPz1BG3WCz220l2a2O9Ut8EPvLVdAHyFBkav0mIPLL6K/TVMj876tKrG4H+fJFk8hkqdgwk62dq/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367613; c=relaxed/simple;
	bh=XL4qDkBOnqZCsTe13gd/1V05gxRQFCFPOWYlpnWgO/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtMNMFP5+yrrxWkvDfOEliilOSSlSdE33GQcStlCIHvslBuv1aRY0+MZiZfFW5xX7rwmq4yRegzfPCZlMOT5l9hwmXAOd42EOq6dtNbWAgMswrrKyP2nZCSv0X6xyqHGOcfHjrYtgRzLDV1YYkWztbpup3xWRuEBnOc5r65ENTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc6gNA1V; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52d259dbe3cso814303e87.0
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 19:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719367610; x=1719972410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rUkotV4f9LEy4RhmQJNvEsrP8HTpUSzDl05Q/mcFp0=;
        b=cc6gNA1VFyU9xUfP5h9wtjQ3c2upqk41jtXjUA6GwlSuxN/oIuEaVvThV9BVYOjAr6
         PkguwdK884ZjSUgqFS4gvZ05KZsbTFXVidj4h4N1m1Qw5zXb7/bTsfJ1SmKOXpFXCutm
         44In4+exFdlSG8yytlIe+pbUqjzv4BKNR9MefZIWXQV+pYCM2qfz9Ay+sVQq6HNZ3P7s
         l4CY64kJZgU5NmPLhJ6Bsb5nK8OxyaRHSjt8zbI74iZgufeEtVbqvNfAnrDghgOioIUr
         EcDrMRGCN2VxfE9RjUARO4dR/NYkFiCFAAm2MKQXatRP+wI6tbC1/0vk3E/s1tbAZYaI
         iDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367610; x=1719972410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rUkotV4f9LEy4RhmQJNvEsrP8HTpUSzDl05Q/mcFp0=;
        b=tZJ8TueNXm14f8nIZgz4erIvyh0IpEf35ipwtwFFVoWq0INUeDlvCdIFCciZatrkO0
         s0/utYGUhv9HyY75DcbRz3d3EKPsgxsKyzo0m7fdYkGOE+mrByAVowNzHx/qasAaCSqH
         TsU3t1mcHVlLzyTQ9xvm1u15ss1xKBsRZ54mgtnh5zkwlxs8/rmsbLBKXUVGMXrnScLb
         sPkADAdsCDTzIC1vON0dLSmyr2VNEDNP8TeAxtNKD4AyzloY1AjHJo6v9404Cst9idoO
         N0h7MV7cGt6/bA1TEFQZfgdusCzznfmNslN7ghFFLfcgO6R/neI4yDDpsDdIquWoZEZe
         Q10w==
X-Forwarded-Encrypted: i=1; AJvYcCX6/veFnjLKHVXUoZLWhjfaEkMLr+rCXrL7s439IRJ9jNaMvMN658gWyqThlyeMAYlyQTkZ/9Nv/Dhmr2AG516DCuOG
X-Gm-Message-State: AOJu0YwiolRyPQr15vP7jNAIrzDZk+0Zfzf8lm1xTNlMtDP1Yh5h4K5b
	Ve740KsWtOp+I2/rxtnb2ARgfzx7HkXcb0a79+1ds1Zelfcte76Jgyplu8VeUOMF+5/s9/m5YYu
	cWOuYQNTeZ6MnuyRsDaO+iEEaZLt1M30g
X-Google-Smtp-Source: AGHT+IFJYRVIkVUBJEr2nJi4R3dzPMtap8h9nsxQpgnwynz22FZ1Z/XOF3czzFABxwXipmgFIbdlbr39kybV7sd+yWc=
X-Received: by 2002:a19:f618:0:b0:52c:dac3:392b with SMTP id
 2adb3069b0e04-52ce061f83dmr7294935e87.33.1719367609747; Tue, 25 Jun 2024
 19:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com> <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com> <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com> <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
 <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com> <CAADnVQ+2JoqJJvinPvKA+4Nm8F9rTrpXBdq4SmbTeq_9bw=mwg@mail.gmail.com>
 <a3eb33c4-b84f-5386-291c-c43d77b39c48@huaweicloud.com> <CAEf4BzZPno3m+G0v8ybxb=SMNbmqofCa5aa_Ukhh2OnZO9NxXw@mail.gmail.com>
 <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com>
In-Reply-To: <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jun 2024 19:06:38 -0700
Message-ID: <CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> Sorry to resurrect the old thread to continue the discussion of APIs for
> qp-trie.
>
> On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> > On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
>
> SNIP
>
> >> updated to allow using dynptr as map key for qp-trie.
> >>> And that's the problem I just mentioned.
> >>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
> >>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
> >> Sorry for misunderstanding your reply. But before switch to the kfuncl
> >> way, could you please point me to some code or function which shows th=
e
> >> specialty of PTR_MAP_KEY ?
> >>
> >>
> > Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> > logic assumes that there is associated struct bpf_map * pointer from
> > which we know fixed-sized key length.
> >
> > But getting back to the topic at hand. I vaguely remember discussion
> > we had, but it would be good if you could summarize it again here to
> > avoid talking past each other. What is the bpf_map_ops changes you
> > were thinking to do? How bpf_attr will look like? How BPF-side API for
> > lookup/delete/update will look like? And then let's go from there?
> > Thanks!
> >
> > .
>
> The APIs for qp-trie are composed of the followings 5 parts:
>
> (1) map definition for qp-trie
>
> The key is bpf_dynptr and map_extra specifies the max length of key.
>
> struct {
>     __uint(type, BPF_MAP_TYPE_QP_TRIE);
>     __type(key, struct bpf_dynptr);
>     __type(value, unsigned int);
>     __uint(map_flags, BPF_F_NO_PREALLOC);
>     __uint(map_extra, 1024);
> } qp_trie SEC(".maps");
>
> (2) bpf_attr
>
> Add key_sz & next_key_sz into anonymous struct to support map with
> variable-size key. We could add value_sz if the map with variable-size
> value is supported in the future.
>
>         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>                 __u32           map_fd;
>                 __aligned_u64   key;
>                 union {
>                         __aligned_u64 value;
>                         __aligned_u64 next_key;
>                 };
>                 __u64           flags;
>                 __u32           key_sz;
>                 __u32           next_key_sz;
>         };
>
> (3) libbpf API
>
> Add bpf_map__get_next_sized_key() to high level APIs.
>
> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
>                                            const void *cur_key,
>                                            size_t cur_key_sz,
>                                            void *next_key, size_t
> *next_key_sz);
>
> Add
> bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delete_si=
zed_elem()/bpf_map_get_next_sized_key()
> to low level APIs.
> These APIs have already considered the case in which map has
> variable-size value, so there will be no need to add other new APIs to
> support such case.
>
> LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, size_t
> key_sz,
>                                          const void *value, size_t value_=
sz,
>                                          __u64 flags);
> LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, size_t
> key_sz,
>                                          void *value, size_t *value_sz,
>                                          __u64 flags);
> LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, size_t
> key_sz,
>                                          __u64 flags);
> LIBBPF_API int bpf_map_get_next_sized_key(int fd,
>                                           const void *key, size_t key_sz,
>                                           void *next_key, size_t
> *next_key_sz);

I don't like this approach.
It looks messy to me and solving one specific case where
key/value is a blob of bytes.
In other words it's taking api to pre-BTF days when everything
was an opaque blob.
I think we need a new object dynptr-like that is composable with other type=
s.
So that user can say that key is
struct map_key {
   long foo;
   dynptr_like array;
   int bar;
};

I'm not sure whether the existing bpf_dynptr fits exactly, but it's
close enough.
Such dynptr_like object should be able to be used as a string.
And map should allow two such strings:
struct map_key {
   dynptr_like file_name;
   dynptr_like dir;
};

and BTF for such map should see distinguish it as two strings
and not as a single blob of bytes.
The observability of bpf maps with bpftool should be able to print it.

The use of such api will look the same from bpf prog and from user space.
bpf prog can do:

 struct map_key key;
 bpf_dynptr_from_whatever(&key.file_name, ...);
 bpf_dynptr_from_whatever(&key.dir, ...);
 bpf_map_lookup_elem(map, &key);

and similar from user space.
bpf_dynptr_user will be a struct with size and a pointer.
The existing sys_bpf commands will stay as-is.
The user space will do:

struct map_key {
   bpf_dynptr_user file_name;
   bpf_dynptr_user dir;
} key;

key.dir.size =3D 1000;
key.dir.ptr =3D malloc(1000);
...
bpf_map_lookup_elem( &key); // existing syscall cmd

In this case sizeof(struct map_key) =3D=3D sizeof(bpf_dynptr_user) * 2 =3D=
=3D 32

Both for bpf prog and for user space.

