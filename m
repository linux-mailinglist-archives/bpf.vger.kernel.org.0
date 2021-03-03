Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C332C1B9
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449567AbhCCWwi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbhCCRkE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 12:40:04 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CABC061760
        for <bpf@vger.kernel.org>; Wed,  3 Mar 2021 09:38:22 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id x19so25425479ybe.0
        for <bpf@vger.kernel.org>; Wed, 03 Mar 2021 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E94ghEiYdC8EH5UxIUQJBfVG+aydEnxQhT3FP8Ug4+w=;
        b=Fw/9WN0NDVVFU6bp73I3Sew+VTVSoO6ACYXbiZP0TUUs/QQ5FAhuxre4ehexTuD7Co
         0gqguBJRmeKhLWH7odT4v8jHEtKD7hz8TfqsBNxQSO34vKg2Dsxfz+xohEa2lC/AQ8t5
         sZbnSkDMhEdvBdwP2rxRNRPxqYK/SJ5NaGP1RBRr329qVvSMAN4d5H/4jtZ8GQekeIFD
         3fgjWbOPPvqoJ8L1wwrTO7wUaAg90RMEoxe6V2g2t2BO6y9QUshCAKrKbmOJkDRm1QSD
         8TyGc0iwzirP5p/xcxo9w4oEi0SjSmIEMFkcZM/rWJ5Quy1jMy5VfZvGIkkLvAQM/5ng
         AfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E94ghEiYdC8EH5UxIUQJBfVG+aydEnxQhT3FP8Ug4+w=;
        b=VZZg6wE/djgYKiKtu2tyW/foX8EFQh7vVZGyfgvYnEcpGBGibcnIMG2+J4ocw/Q/Ru
         6Oq6spGdq8eoEq7csJjJXXSEIh1gRSiOCSD/aJP+luHGAksuco6FwER7nb03pAfsdvtg
         eJnbM+IqtW/OzefMsSUhvKmoKFjg4BujJtCWwgd77/IdTWDa/AsxtmP0dhVGhY44Vunw
         ahv95okBOyq2kvCdJKYxL1V1uwHHwXNHAq0sj6FbHpCx7JguTZuQNkcrA6UwrB9UGEtQ
         xrKRSbw2m/VpZW3dNZ9S/4Ux+T19fPdzBQadLsx0ZahFNZEQut2KShp/AJuv739DbMQE
         L8nA==
X-Gm-Message-State: AOAM5326KtsfciskYDKq4wr3sm28bHPjSwFw5UpAwbK5bDypsKnGT01B
        NzCNspdtncOav/M9vGnmksyauLtUvEpOhOI+IIQ3Fjvq2/7baA==
X-Google-Smtp-Source: ABdhPJwZeoQ/R8OGAc03ZeVHm7p9gGYYwwkJAXpZuMUSnUpkyZ+th8R3HWU6up1EDdhtFBzug8GbGVEHKoM9dzTOtxE=
X-Received: by 2002:a25:e010:: with SMTP id x16mr453793ybg.511.1614793101040;
 Wed, 03 Mar 2021 09:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20210302171947.2268128-1-joe@cilium.io> <20210302171947.2268128-9-joe@cilium.io>
In-Reply-To: <20210302171947.2268128-9-joe@cilium.io>
From:   Brian Vazquez <brianvv@google.com>
Date:   Wed, 3 Mar 2021 09:38:10 -0800
Message-ID: <CAMzD94RE=p9C4FaOA1C6tiSUuqnPv3k8dj2Lb1DgnuJ_vvAX=w@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 08/15] bpf: Document BPF_MAP_*_BATCH syscall commands
To:     Joe Stringer <joe@cilium.io>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joe, thanks for documenting this.

Your description of the functions usage looks good to me.

Acked-by: Brian Vazquez <brianvv@google.com>




On Tue, Mar 2, 2021 at 9:20 AM Joe Stringer <joe@cilium.io> wrote:
>
> Based roughly on the following commits:
> * Commit cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> * Commit 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> * Commit aa2e93b8e58e ("bpf: Add generic support for update and delete
>   batch ops")
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>
> ---
> CC: Brian Vazquez <brianvv@google.com>
> CC: Yonghong Song <yhs@fb.com>
> ---
>  include/uapi/linux/bpf.h | 114 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 111 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0cf92ef011f1..c8b9d19fce22 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -553,13 +553,55 @@ union bpf_iter_link_info {
>   *     Description
>   *             Iterate and fetch multiple elements in a map.
>   *
> + *             Two opaque values are used to manage batch operations,
> + *             *in_batch* and *out_batch*. Initially, *in_batch* must be=
 set
> + *             to NULL to begin the batched operation. After each subseq=
uent
> + *             **BPF_MAP_LOOKUP_BATCH**, the caller should pass the resu=
ltant
> + *             *out_batch* as the *in_batch* for the next operation to
> + *             continue iteration from the current point.
> + *
> + *             The *keys* and *values* are output parameters which must =
point
> + *             to memory large enough to hold *count* items based on the=
 key
> + *             and value size of the map *map_fd*. The *keys* buffer mus=
t be
> + *             of *key_size* * *count*. The *values* buffer must be of
> + *             *value_size* * *count*.
> + *
> + *             The *elem_flags* argument may be specified as one of the
> + *             following:
> + *
> + *             **BPF_F_LOCK**
> + *                     Look up the value of a spin-locked map without
> + *                     returning the lock. This must be specified if the
> + *                     elements contain a spinlock.
> + *
> + *             On success, *count* elements from the map are copied into=
 the
> + *             user buffer, with the keys copied into *keys* and the val=
ues
> + *             copied into the corresponding indices in *values*.
> + *
> + *             If an error is returned and *errno* is not **EFAULT**, *c=
ount*
> + *             is set to the number of successfully processed elements.
> + *
>   *     Return
>   *             Returns zero on success. On error, -1 is returned and *er=
rno*
>   *             is set appropriately.
>   *
> + *             May set *errno* to **ENOSPC** to indicate that *keys* or
> + *             *values* is too small to dump an entire bucket during
> + *             iteration of a hash-based map type.
> + *
>   * BPF_MAP_LOOKUP_AND_DELETE_BATCH
>   *     Description
> - *             Iterate and delete multiple elements in a map.
> + *             Iterate and delete all elements in a map.
> + *
> + *             This operation has the same behavior as
> + *             **BPF_MAP_LOOKUP_BATCH** with two exceptions:
> + *
> + *             * Every element that is successfully returned is also del=
eted
> + *               from the map. This is at least *count* elements. Note t=
hat
> + *               *count* is both an input and an output parameter.
> + *             * Upon returning with *errno* set to **EFAULT**, up to
> + *               *count* elements may be deleted without returning the k=
eys
> + *               and values of the deleted elements.
>   *
>   *     Return
>   *             Returns zero on success. On error, -1 is returned and *er=
rno*
> @@ -567,15 +609,81 @@ union bpf_iter_link_info {
>   *
>   * BPF_MAP_UPDATE_BATCH
>   *     Description
> - *             Iterate and update multiple elements in a map.
> + *             Update multiple elements in a map by *key*.
> + *
> + *             The *keys* and *values* are input parameters which must p=
oint
> + *             to memory large enough to hold *count* items based on the=
 key
> + *             and value size of the map *map_fd*. The *keys* buffer mus=
t be
> + *             of *key_size* * *count*. The *values* buffer must be of
> + *             *value_size* * *count*.
> + *
> + *             Each element specified in *keys* is sequentially updated =
to the
> + *             value in the corresponding index in *values*. The *in_bat=
ch*
> + *             and *out_batch* parameters are ignored and should be zero=
ed.
> + *
> + *             The *elem_flags* argument should be specified as one of t=
he
> + *             following:
> + *
> + *             **BPF_ANY**
> + *                     Create new elements or update a existing elements=
.
> + *             **BPF_NOEXIST**
> + *                     Create new elements only if they do not exist.
> + *             **BPF_EXIST**
> + *                     Update existing elements.
> + *             **BPF_F_LOCK**
> + *                     Update spin_lock-ed map elements. This must be
> + *                     specified if the map value contains a spinlock.
> + *
> + *             On success, *count* elements from the map are updated.
> + *
> + *             If an error is returned and *errno* is not **EFAULT**, *c=
ount*
> + *             is set to the number of successfully processed elements.
>   *
>   *     Return
>   *             Returns zero on success. On error, -1 is returned and *er=
rno*
>   *             is set appropriately.
>   *
> + *             May set *errno* to **EINVAL**, **EPERM**, **ENOMEM**, or
> + *             **E2BIG**. **E2BIG** indicates that the number of element=
s in
> + *             the map reached the *max_entries* limit specified at map
> + *             creation time.
> + *
> + *             May set *errno* to one of the following error codes under
> + *             specific circumstances:
> + *
> + *             **EEXIST**
> + *                     If *flags* specifies **BPF_NOEXIST** and the elem=
ent
> + *                     with *key* already exists in the map.
> + *             **ENOENT**
> + *                     If *flags* specifies **BPF_EXIST** and the elemen=
t with
> + *                     *key* does not exist in the map.
> + *
>   * BPF_MAP_DELETE_BATCH
>   *     Description
> - *             Iterate and delete multiple elements in a map.
> + *             Delete multiple elements in a map by *key*.
> + *
> + *             The *keys* parameter is an input parameter which must poi=
nt
> + *             to memory large enough to hold *count* items based on the=
 key
> + *             size of the map *map_fd*, that is, *key_size* * *count*.
> + *
> + *             Each element specified in *keys* is sequentially deleted.=
 The
> + *             *in_batch*, *out_batch*, and *values* parameters are igno=
red
> + *             and should be zeroed.
> + *
> + *             The *elem_flags* argument may be specified as one of the
> + *             following:
> + *
> + *             **BPF_F_LOCK**
> + *                     Look up the value of a spin-locked map without
> + *                     returning the lock. This must be specified if the
> + *                     elements contain a spinlock.
> + *
> + *             On success, *count* elements from the map are updated.
> + *
> + *             If an error is returned and *errno* is not **EFAULT**, *c=
ount*
> + *             is set to the number of successfully processed elements. =
If
> + *             *errno* is **EFAULT**, up to *count* elements may be been
> + *             deleted.
>   *
>   *     Return
>   *             Returns zero on success. On error, -1 is returned and *er=
rno*
> --
> 2.27.0
>
