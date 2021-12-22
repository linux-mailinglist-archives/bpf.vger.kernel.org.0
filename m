Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336F547CA09
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 01:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhLVAGr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 19:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhLVAGq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 19:06:46 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A547FC061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 16:06:46 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 19so160492ioz.4
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 16:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7R4SnyTUZhw1Se6gldmGyvoz6W55yfLcXnq9pf/0DE=;
        b=cvr0YM2bVKy8KeX2sdH28ardY2bAXwm9kjB9+5dnyQVxTgXLLSfWTFQ80LEbVypEO3
         LE6wvwoJRp3QR3i4WYeoGh0DxksJIyZEdWPI/SPn/E/ICcbFGwOdrd0rRVI5CSQBuCpw
         KVHfSXADBW25WPd3Flfs4lsDDD8odIVHHbPPE8uslOOHsB1uqZj617rgqtIq/7Q48m5q
         CKfzOXboO7JDKWP6cepEUHmW/4vIovol+58QQi6tksKknVis5hpLUjlxLitRTIoOGx58
         BvO1kESXw4QVSNrdcrEbeAYv5gHQUD4xmO9eukOMhpVJH3C9Df9QuacRPXC5U/Hh95xs
         M89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7R4SnyTUZhw1Se6gldmGyvoz6W55yfLcXnq9pf/0DE=;
        b=YaU1M4cmWcrIRmOHWS2nzmtJnXsKtBOpe2MlVrpHq6yx1l30VkZa4qNtRYkD+cVC7T
         QY9jdXRtTFM4Aa1vnm3IhGNhORP7igFgwwMtHBF1q7rq+RtcSoupCsBX3N1g0iAwKTDR
         SkMEFHgy99KcG56kdrwT/hISIJbE+eSBDWTbAXoXhpUD3Xo46lLeLuG7+Dj1yvU+krYO
         oIcvWeONXxI2+yu7eRPt4dpH0c07k/nLdTS7C99ue969TXPteGIHf8F/DUpkM1MAj8QI
         SuuhLwPRpAk0cGgs8DgSpr26KvyUx2Z5TCAeuyYhdm9K2bs5TeST6dhf0LsBrMAXcURu
         RSTw==
X-Gm-Message-State: AOAM531uxtGS7ebWUGfx90laKzwWSeqoYQ/13eRtOSgqne8NdNeNt3XD
        1e2pgUkgspEJoEG6z2SMSa3GDur7CnCzSGqdxVs=
X-Google-Smtp-Source: ABdhPJyaWSGROkYzvpwdminhiehuTLe5gG4Pdx9EJ69iswJeVd2S9mcEN1+FtccsXNSePNU9kgb/s5dA6xISErIHAwc=
X-Received: by 2002:a5d:9f01:: with SMTP id q1mr254893iot.144.1640131606040;
 Tue, 21 Dec 2021 16:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20211220054048.54845-1-grantseltzer@gmail.com>
In-Reply-To: <20211220054048.54845-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Dec 2021 16:06:34 -0800
Message-ID: <CAEf4BzYOkkh3Cn6gBFx6SNwy5_fUewZkAxgiidoh-2ECtrwexQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add documentation for bpf_map batch operations
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 19, 2021 at 9:42 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds documention for:

typo: documentation :)

>
> - bpf_map_delete_batch()
> - bpf_map_lookup_batch()
> - bpf_map_lookup_and_delete_batch()
> - bpf_map_update_batch()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/bpf.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 00619f64a040..b1a2ac9ca9c7 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -254,20 +254,113 @@ struct bpf_map_batch_opts {
>  };
>  #define bpf_map_batch_opts__last_field flags
>
> +
> +/**
> + * @brief **bpf_map_delete_batch()** allows for batch deletion of multiple
> + * elements in a BPF map.
> + *
> + * The parameter *keys* points to a memory address large enough to hold

"memory address large enough" is very misleading... "points to buffer
large enough"?

But in this case, keys is just an input array of keys, no? In such a
case just saying that "*keys* points to an array of *count* keys"
would be pretty unambiguous, right?

> + * *count* keys of elements in the map *fd*.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys memory address large enough to hold *count* * *key_size*
> + * @param count number of elements in the map to sequentially delete
> + * @param opts options for configuring the way the batch deletion works
> + * @return  int error code, 0 if no error (errno is also set to error)

Usually success is described first. Can you please rephrase here and
in others to something along the lines of:

0, on success; negative error code, otherwise (errno is also set to
the error code)

?

> + */
>  LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,

if keys are really just an input, let's mark them as `const void *`,
while we are documenting all this?

>                                     __u32 *count,
>                                     const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_batch()** allows for iteration of BPF map elements.
> + *
> + * The parameter *in_batch* is the address of the first element in the batch to read.
> + * *out_batch* is an output parameter that should be passed as *in_batch* to subsequent
> + * calls to **bpf_map_lookup_batch()**. NULL can be passed for *in_batch* to set
> + * *out_batch* as the first element of the map.
> + *
> + * The *keys* and *values* are output parameters which must point to memory large enough to
> + * hold *count* items based on the key and value size of the map *map_fd*. The *keys*
> + * buffer must be of *key_size* * *count*. The *values* buffer must be of
> + * *value_size* * *count*.
> + *
> + * @param fd BPF map file descriptor
> + * @param in_batch address of the first element in batch to read, can pass NULL to
> + * get address of the first element in *out_batch*
> + * @param out_batch output parameter that should be passed to next call as *in_batch*
> + * @param keys memory address large enough to hold *count* * *key_size*
> + * @param values memory address large enough to hold *count* * *value_size*

again this "memory address large enough" wording. Address is fixed at
32-bit/64-bit, depending on the architecture. It's quite a confusing
wording that you chose...

> + * @param count number of elements in the map to read in batch
> + * @param opts options for configuring the way the batch lookup works
> + * @return int error code, 0 if no error (errno is also set to error)
> + */
>  LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
>                                     void *keys, void *values, __u32 *count,
>                                     const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_lookup_and_delete_batch()** allows for iteration of BPF map
> + * elements where each element is deleted after being retrieved.
> + *
> + * Note that *count* is an input and output parameter, where on output it
> + * represents how many elements were succesfully deleted. Also note that if
> + * **EFAULT** is returned up to *count* elements may have been deleted without
> + * being returned via the *keys* and *values* output parameters.
> + *
> + * @param fd BPF map file descriptor
> + * @param in_batch address of the first element in batch to read, can pass NULL to
> + * get address of the first element in *out_batch*
> + * @param out_batch output parameter that should be passed to next call as *in_batch*
> + * @param keys memory address large enough to hold *count* * *key_size*
> + * @param values memory address large enough to hold *count* * *value_size*
> + * @param count number of elements in the map to read and delete in batch
> + * @param opts options for configuring the way the batch lookup and delete works
> + * @return int error code, 0 if no error (errno is also set to error)
> + * See note on EFAULT.
> + */
>  LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
>                                         void *out_batch, void *keys,
>                                         void *values, __u32 *count,
>                                         const struct bpf_map_batch_opts *opts);
> +
> +/**
> + * @brief **bpf_map_update_batch()** updates multiple elements in a map
> + * by specifiying keys and their corresponding values.
> + *
> + * The *keys* and *values* paremeters must point to memory large enough
> + * to hold *count* items based on the key and value size of the map.
> + *
> + * The *opts* parameter can be used to control how *bpf_map_update_batch()*
> + * should handle keys that either do or do not already exist in the map.
> + * In particular the *flags* field of *bpf_map_batch_opts* can be
> + * one of the following:
> + *
> + * **BPF_ANY**
> + *     Create new elements or update a existing elements.

just "update existing"

> + *
> + * **BPF_NOEXIST**
> + *     Create new elements only if they do not exist.
> + *
> + * **BPF_EXIST**
> + *     Update existing elements.
> + *
> + * **BPF_F_LOCK**
> + *     Update spin_lock-ed map elements. This must be
> + *     specified if the map value contains a spinlock.
> + *
> + * @param fd BPF map file descriptor
> + * @param keys memory address large enough to hold *count* * *key_size*
> + * @param values memory address large enough to hold *count* * *value_size*
> + * @param count number of elements in the map to update in batch
> + * @param opts options for configuring the way the batch update works
> + * @return int error code, 0 if no error (errno is also set to error)
> + */
>  LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,

I think keys are also `const void *`, while values are written into.
Let's update accordingly.

>                                     __u32 *count,
>                                     const struct bpf_map_batch_opts *opts);
>
> +
>  LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
>  LIBBPF_API int bpf_obj_get(const char *pathname);
>
> --
> 2.33.1
>
