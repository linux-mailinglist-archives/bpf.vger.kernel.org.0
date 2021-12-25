Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7E47F467
	for <lists+bpf@lfdr.de>; Sat, 25 Dec 2021 21:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhLYUdL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Dec 2021 15:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhLYUdL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Dec 2021 15:33:11 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C501C061401
        for <bpf@vger.kernel.org>; Sat, 25 Dec 2021 12:33:11 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id x6so14360055iol.13
        for <bpf@vger.kernel.org>; Sat, 25 Dec 2021 12:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oic2CGHmS8lGt5C1238VywYwmxTU2hGIgyUCKaP8oAo=;
        b=VYhMac1cgKdue5FA/eFIVFagUKacRTRruPtP7h24qfqNqmr4lbANM2lGufTIFz1nqI
         xhoc//s/2jbqHjt48+hJe/N35K/AF61zi3O7oTg1oS6+sxhxejqpDkyIsK2KXS7p1VKr
         IrH8Ay08PuxPMNZ+hdSE+wWTsTclxrz5Zb1NAEE1XaqZ7nqBIs4B2mSe9uNcnAR2aGFV
         tbt0HBfRpIR9wS/nm7edPOLUEfrF2wfL4WTr8h4yxDYM6hjeD/H7PU8vovpadXE/NjDI
         CE2reHmKnpJLOwuNoPMMA/pIyGofaZaEI5w9B5dv+kEciFBfqsvaoaVx+9ruoNkFkxDV
         x+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oic2CGHmS8lGt5C1238VywYwmxTU2hGIgyUCKaP8oAo=;
        b=l62J7lJgi53LKWYpb/TdVXuwXfVISYFv5u4utP6bEzniMtE8A9Flalw1XHOqgLGfhM
         CI94p1YhIQnwqH01+Ybsj/1AW8RmaFQQ821eWJtrNd+SmxdMNXHhi8PPNsDVNsFNOBf2
         gM3P6fwgwtaZzgoA3XM894xGZ1ekN6O0v6SHqhyOgCTJ4gVGvQ2Nhckrg37skV/00ilj
         GusqxHzrVJItQ7HcFea5lYqmp3GjKT/55cdxDkXIUtjc1MEEXql4ZoZ0NsHhOhZuSrDm
         xAO7mPX3PMUwaUKUVPbmJgfhAMr9l2YlFQL9ATtJkZJCwEhNth2IKeOZkkcdmitJb28B
         lalQ==
X-Gm-Message-State: AOAM532ccbey+9xE9PaOFOhdVPPBGgzH3or7CUttpXa2SbKQyU7n8wKe
        fY800mNrkyZP5YR8+eRJX8Y9YsTt9QEq1sJmY1g=
X-Google-Smtp-Source: ABdhPJwScTkuB+rytFTZOqtVZ1aRB779TBQj9cN5bZKWrJRkp1Pm3Sd7wv7Ff9PgVNGMr0hM6MTUOSPXBgS9TSpzseE=
X-Received: by 2002:a05:6638:95b:: with SMTP id f27mr2443781jad.273.1640464390054;
 Sat, 25 Dec 2021 12:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20211220054048.54845-1-grantseltzer@gmail.com> <CAEf4BzYOkkh3Cn6gBFx6SNwy5_fUewZkAxgiidoh-2ECtrwexQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYOkkh3Cn6gBFx6SNwy5_fUewZkAxgiidoh-2ECtrwexQ@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Sat, 25 Dec 2021 15:32:59 -0500
Message-ID: <CAO658oU2kTmcc6MoDzEa2TB5QN4-sYmggPKQMgLGibOTNMGPOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add documentation for bpf_map batch operations
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 21, 2021 at 7:06 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Dec 19, 2021 at 9:42 PM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds documention for:
>
> typo: documentation :)
>
> >
> > - bpf_map_delete_batch()
> > - bpf_map_lookup_batch()
> > - bpf_map_lookup_and_delete_batch()
> > - bpf_map_update_batch()
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > ---
> >  tools/lib/bpf/bpf.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 00619f64a040..b1a2ac9ca9c7 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -254,20 +254,113 @@ struct bpf_map_batch_opts {
> >  };
> >  #define bpf_map_batch_opts__last_field flags
> >
> > +
> > +/**
> > + * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
> > + * elements in a BPF map.
> > + *
> > + * The parameter *keys* points to a memory address large enough to hold
>
> "memory address large enough" is very misleading... "points to buffer
> large enough"?
>
> But in this case, keys is just an input array of keys, no? In such a
> case just saying that "*keys* points to an array of *count* keys"
> would be pretty unambiguous, right?
>
> > + * *count* keys of elements in the map *fd*.
> > + *
> > + * @param fd BPF map file descriptor
> > + * @param keys memory address large enough to hold *count* * *key_size*
> > + * @param count number of elements in the map to sequentially delete
> > + * @param opts options for configuring the way the batch deletion works
> > + * @return  int error code, 0 if no error (errno is also set to error)
>
> Usually success is described first. Can you please rephrase here and
> in others to something along the lines of:
>
> 0, on success; negative error code, otherwise (errno is also set to
> the error code)
>
> ?
>
> > + */
> >  LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
>
> if keys are really just an input, let's mark them as `const void *`,
> while we are documenting all this?
>
> >                                     __u32 *count,
> >                                     const struct bpf_map_batch_opts *opts);
> > +
> > +/**
> > + * @brief **bpf_map_lookup_batch()** allows for iteration of BPF map elements.
> > + *
> > + * The parameter *in_batch* is the address of the first element in the batch to read.
> > + * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
> > + * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to set
> > + * *out_batch* as the first element of the map.
> > + *
> > + * The *keys* and *values* are output parameters which must point to memory large enough to
> > + * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
> > + * buffer must be of *key_size* * *count*. The *values* buffer must be of
> > + * *value_size* * *count*.
> > + *
> > + * @param fd BPF map file descriptor
> > + * @param in_batch address of the first element in batch to read, can pass NULL to
> > + * get address of the first element in *out_batch*
> > + * @param out_batch output parameter that should be passed to next call as *in_batch*
> > + * @param keys memory address large enough to hold *count* * *key_size*
> > + * @param values memory address large enough to hold *count* * *value_size*
>
> again this "memory address large enough" wording. Address is fixed at
> 32-bit/64-bit, depending on the architecture. It's quite a confusing
> wording that you chose...
>
> > + * @param count number of elements in the map to read in batch
> > + * @param opts options for configuring the way the batch lookup works
> > + * @return int error code, 0 if no error (errno is also set to error)
> > + */
> >  LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
> >                                     void *keys, void *values, __u32 *count,
> >                                     const struct bpf_map_batch_opts *opts);
> > +
> > +/**
> > + * @brief **bpf_map_lookup_and_delete_batch()** allows for iteration of BPF map
> > + * elements where each element is deleted after being retrieved.
> > + *
> > + * Note that *count* is an input and output parameter, where on output it
> > + * represents how many elements were succesfully deleted. Also note that if
> > + * **EFAULT** is returned up to *count* elements may have been deleted without
> > + * being returned via the *keys* and *values* output parameters.
> > + *
> > + * @param fd BPF map file descriptor
> > + * @param in_batch address of the first element in batch to read, can pass NULL to
> > + * get address of the first element in *out_batch*
> > + * @param out_batch output parameter that should be passed to next call as *in_batch*
> > + * @param keys memory address large enough to hold *count* * *key_size*
> > + * @param values memory address large enough to hold *count* * *value_size*
> > + * @param count number of elements in the map to read and delete in batch
> > + * @param opts options for configuring the way the batch lookup and delete works
> > + * @return int error code, 0 if no error (errno is also set to error)
> > + * See note on EFAULT.
> > + */
> >  LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
> >                                         void *out_batch, void *keys,
> >                                         void *values, __u32 *count,
> >                                         const struct bpf_map_batch_opts *opts);
> > +
> > +/**
> > + * @brief **bpf_map_update_batch()** updates multiple elements in a map
> > + * by specifiying keys and their corresponding values.
> > + *
> > + * The *keys* and *values* paremeters must point to memory large enough
> > + * to hold *count* items based on the key and value size of the map.
> > + *
> > + * The *opts* parameter can be used to control how *bpf_map_update_batch()*
> > + * should handle keys that either do or do not already exist in the map.
> > + * In particular the *flags* field of *bpf_map_batch_opts* can be
> > + * one of the following:
> > + *
> > + * **BPF_ANY**
> > + *     Create new elements or update a existing elements.
>
> just "update existing"
>
> > + *
> > + * **BPF_NOEXIST**
> > + *     Create new elements only if they do not exist.
> > + *
> > + * **BPF_EXIST**
> > + *     Update existing elements.
> > + *
> > + * **BPF_F_LOCK**
> > + *     Update spin_lock-ed map elements. This must be
> > + *     specified if the map value contains a spinlock.
> > + *
> > + * @param fd BPF map file descriptor
> > + * @param keys memory address large enough to hold *count* * *key_size*
> > + * @param values memory address large enough to hold *count* * *value_size*
> > + * @param count number of elements in the map to update in batch
> > + * @param opts options for configuring the way the batch update works
> > + * @return int error code, 0 if no error (errno is also set to error)
> > + */
> >  LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
>
> I think keys are also `const void *`, while values are written into.
> Let's update accordingly.

I don't think values are written into, going to mark that as `const
void *` as well.

>
> >                                     __u32 *count,
> >                                     const struct bpf_map_batch_opts *opts);
> >
> > +
> >  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
> >  LIBBPF_API int bpf_obj_get(const char *pathname);
> >
> > --
> > 2.33.1
> >
