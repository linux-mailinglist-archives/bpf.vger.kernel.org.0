Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3954F483696
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 19:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiACSI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 13:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiACSI6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Jan 2022 13:08:58 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4FAC061761
        for <bpf@vger.kernel.org>; Mon,  3 Jan 2022 10:08:58 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 19so40706579ioz.4
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 10:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L1uZ5wmF1lHksYOC6rnbhc3HWpv/krbyADmwA38wKuI=;
        b=O886RqRyACtzefoogHjlyLwgX90vlY6JoPohhLcpgQcfuDD6aG1T54AdvT/ie4bEhE
         CdCuL1Qg7HPJwtPNXz21g2Qrcj14if9rbfjN9UEykSFNezUdK2bazd6fxw/iVr5NFL6G
         MHGgrClqoVIJzBCbrKQJK+L90k27wsY3HXnnHhUVk7Ey+upOWmcq1B2wAm6uBfqnVTGu
         f5sgMVaYY952ldrl2wV1K26rzvYMCv0x9xlB1MZE7Qyk1aSLBcI3Tuo+NqSDHmA5iZSO
         51IycqayUxHM8sFosbNS3OOz9wJceNyfcs5l3U9Ae2Ht93N9zfjEOPSQ4E9DSYRqtY6Z
         XKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L1uZ5wmF1lHksYOC6rnbhc3HWpv/krbyADmwA38wKuI=;
        b=R6jHsrM+SwvwRg+YziGVknUPp9rN7996nBt90VDO3pW5iUXfyMs2qtm6SGrZhJCZ75
         TQlgX3BTNo2mqa+APhPByrT4UsiWcnbgndkkeCfbdyddy701GH1tJEmE7ybdE2FrKuO/
         Xllj2QDNG341jTOdIY83R2DkgYgo2l0k9MOZA7GBUJ0FekWB+MLP0Tt12GYpUifuLcI3
         tmvZK7ardR5gTKz9VFbYEIVrPMrT3GV7OmxRanJXe9r2CC2tNP8W0Wx67AC+19bnQij4
         LiXr4K8/IiufEeOQAdoB/d9bvEvuZ1/Sn7hIux2mcFCGWuDmKw3z3qfxPMAt9mypqroj
         fylw==
X-Gm-Message-State: AOAM532XpvpXE7Dew1YMAJnnhDFrC3Ag/gSFa9HLBz5su9TTIafggN0i
        Yrr3mUPzIWBrNPeGmrKk5P5eniR5BKY1WMb59Xk=
X-Google-Smtp-Source: ABdhPJzq5UxbufOE2cJKIJtsEBu28iPeSOYZihhsSqLXwyYsKkrMY8ejv84hvGoOe/bxlfqNYa0RtPTt3G4Eb6G5aaM=
X-Received: by 2002:a05:6602:1484:: with SMTP id a4mr21127703iow.35.1641233337784;
 Mon, 03 Jan 2022 10:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20211225203717.35718-1-grantseltzer@gmail.com> <b572def1-cfdc-6ae3-3772-d92660170fda@gmail.com>
In-Reply-To: <b572def1-cfdc-6ae3-3772-d92660170fda@gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 3 Jan 2022 13:08:46 -0500
Message-ID: <CAO658oVFNA7JMPozQTF4vw5TDdwSu6dR_KdxgKvER8BNhiL9aA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Add documentation for bpf_map batch operations
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 27, 2021 at 7:25 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2021/12/26 4:37 AM, grantseltzer wrote:
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds documentation for:
> >
> > - bpf_map_delete_batch()
> > - bpf_map_lookup_batch()
> > - bpf_map_lookup_and_delete_batch()
> > - bpf_map_update_batch()
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > ---
> >  tools/lib/bpf/bpf.c |   4 +-
> >  tools/lib/bpf/bpf.h | 112 +++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 112 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 9b64eed2b003..25f3d6f85fe5 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -691,7 +691,7 @@ static int bpf_map_batch_common(int cmd, int fd, vo=
id  *in_batch,
> >       return libbpf_err_errno(ret);
> >  }
> >
> > -int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
> > +int bpf_map_delete_batch(int fd, const void *keys, __u32 *count,
>
> Maybe you should drop these const qualifier changes.

Can you help me understand the benefit of using the const qualifier in
this context? I added it at Andrii's suggestion without proper
understanding. I understand that it will properly convey that the keys
or values aren't output parameters like in other batch operation
functions, I don't think it would change where the underlying data is
stored, just the pointer variable.

Is it worth it to have seperate 'common' functions for the sake of
having a const qualifier?
>
> All batch operations use `bpf_map_batch_common`, which has the following =
signature:
>
> static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>                                 void *out_batch, void *keys, void *values=
,
>                                 __u32 *count,
>                                 const struct bpf_map_batch_opts *opts)
>
> Adding these const qualifiers causes the following error:
>
> bpf.c:698:15: error: passing argument 5 of =E2=80=98bpf_map_batch_common=
=E2=80=99 discards
> =E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddis=
carded-qualifiers]
>
> >                        const struct bpf_map_batch_opts *opts)
> >  {
> >       return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
> > @@ -715,7 +715,7 @@ int bpf_map_lookup_and_delete_batch(int fd, void *i=
n_batch, void *out_batch,
> >                                   count, opts);
> >  }
> >
> > -int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *coun=
t,
> > +int bpf_map_update_batch(int fd, const void *keys, const void *values,=
 __u32 *count,
> >                        const struct bpf_map_batch_opts *opts)
> >  {
> >       return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH, fd, NULL, NULL,
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 00619f64a040..01011747f127 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -254,20 +254,128 @@ struct bpf_map_batch_opts {
> >  };
> >  #define bpf_map_batch_opts__last_field flags
> >
> > -LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
> > +
> > +/**
> > + * @brief **bpf_map_delete_batch()** allows for batch deletion of mult=
iple
> > + * elements in a BPF map.
> > + *
> > + * @param fd BPF map file descriptor
> > + * @param keys pointer to an array of *count* keys
> > + * @param count number of elements in the map to sequentially delete
> > + * @param opts options for configuring the way the batch deletion work=
s
> > + * @return 0, on success; negative error code, otherwise (errno is als=
o set to
> > + * the error code)
> > + */
> > +LIBBPF_API int bpf_map_delete_batch(int fd, const void *keys,
> >                                   __u32 *count,
> >                                   const struct bpf_map_batch_opts *opts=
);
> > +
> > +/**
> > + * @brief **bpf_map_lookup_batch()** allows for batch lookup of BPF ma=
p elements.
> > + *
> > + * The parameter *in_batch* is the address of the first element in the=
 batch to read.
> > + * *out_batch* is an output parameter that should be passed as *in_bat=
ch* to subsequent
> > + * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_bat=
ch* to indicate
> > + * that the batched lookup starts from the beginning of the map.
> > + *
> > + * The *keys* and *values* are output parameters which must point to m=
emory large enough to
> > + * hold *count* items based on the key and value size of the map *map_=
fd*. The *keys*
> > + * buffer must be of *key_size* * *count*. The *values* buffer must be=
 of
> > + * *value_size* * *count*.
> > + *
> > + * @param fd BPF map file descriptor
> > + * @param in_batch address of the first element in batch to read, can =
pass NULL to
> > + * indicate that the batched lookup starts from the beginning of the m=
ap.
> > + * @param out_batch output parameter that should be passed to next cal=
l as *in_batch*
> > + * @param keys pointer to an array large enough for *count* keys
> > + * @param values pointer to an array large enough for *count* values
> > + * @param count number of elements in the map to read in batch. If ENO=
ENT is
> > + * returned, count will be set as the number of elements that were rea=
d before
> > + * running out of entries in the map
> > + * @param opts options for configuring the way the batch lookup works
> > + * @return 0, on success; negative error code, otherwise (errno is als=
o set to
> > + * the error code)
> > + */
> >  LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_=
batch,
> >                                   void *keys, void *values, __u32 *coun=
t,
> >                                   const struct bpf_map_batch_opts *opts=
);
> > +
> > +/**
> > + * @brief **bpf_map_lookup_and_delete_batch()** allows for batch looku=
p and deletion
> > + * of BPF map elements where each element is deleted after being retri=
eved.
> > + *
> > + * Note that *count* is an input and output parameter, where on output=
 it
> > + * represents how many elements were successfully deleted. Also note t=
hat if
> > + * **EFAULT** is returned up to *count* elements may have been deleted=
 without
> > + * being returned via the *keys* and *values* output parameters. If **=
ENOENT**
> > + * is returned then *count* will be set to the number of elements that=
 were read
> > + * before running out of entries in the map.
> > + *
> > + * @param fd BPF map file descriptor
> > + * @param in_batch address of the first element in batch to read, can =
pass NULL to
> > + * get address of the first element in *out_batch*
> > + * @param out_batch output parameter that should be passed to next cal=
l as *in_batch*
> > + * @param keys pointer to an array of *count* keys
> > + * @param values pointer to an array large enough for *count* values
> > + * @param count input and output parameter; on input it's the number o=
f elements
> > + * in the map to read and delete in batch; on output it represents num=
ber of elements
> > + * that were successfully read and deleted
> > + * If ENOENT is returned, count will be set as the number of elements =
that were
> > + * read before running out of entries in the map
> > + * @param opts options for configuring the way the batch lookup and de=
lete works
> > + * @return 0, on success; negative error code, otherwise (errno is als=
o set to
> > + * the error code)
> > + */
> >  LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
> >                                       void *out_batch, void *keys,
> >                                       void *values, __u32 *count,
> >                                       const struct bpf_map_batch_opts *=
opts);
> > -LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
> > +
> > +/**
> > + * @brief **bpf_map_update_batch()** updates multiple elements in a ma=
p
> > + * by specifying keys and their corresponding values.
> > + *
> > + * The *keys* and *values* parameters must point to memory large enoug=
h
> > + * to hold *count* items based on the key and value size of the map.
> > + *
> > + * The *opts* parameter can be used to control how *bpf_map_update_bat=
ch()*
> > + * should handle keys that either do or do not already exist in the ma=
p.
> > + * In particular the *flags* parameter of *bpf_map_batch_opts* can be
> > + * one of the following:
> > + *
> > + * Note that *count* is an input and output parameter, where on output=
 it
> > + * represents how many elements were successfully updated. Also note t=
hat if
> > + * **EFAULT** then *count* should not be trusted to be correct.
> > + *
> > + * **BPF_ANY**
> > + *     Create new elements or update existing.
> > + *
> > + * **BPF_NOEXIST**
> > + *    Create new elements only if they do not exist.
> > + *
> > + * **BPF_EXIST**
> > + *    Update existing elements.
> > + *
> > + * **BPF_F_LOCK**
> > + *    Update spin_lock-ed map elements. This must be
> > + *    specified if the map value contains a spinlock.
> > + *
> > + * @param fd BPF map file descriptor
> > + * @param keys pointer to an array of *count* keys
> > + * @param values pointer to an array of *count* values
> > + * @param count input and output parameter; on input it's the number o=
f elements
> > + * in the map to update in batch; on output it represents the number o=
f elements
> > + * that were successfully updated. If EFAULT is returned, *count* shou=
ld not
> > + * be trusted to be correct.
> > + * @param opts options for configuring the way the batch update works
> > + * @return 0, on success; negative error code, otherwise (errno is als=
o set to
> > + * the error code)
> > + */
> > +LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const vo=
id *values,
> >                                   __u32 *count,
> >                                   const struct bpf_map_batch_opts *opts=
);
> >
> > +
> >  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
> >  LIBBPF_API int bpf_obj_get(const char *pathname);
> >
