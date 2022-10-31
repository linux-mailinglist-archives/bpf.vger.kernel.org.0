Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4A613659
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 13:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJaM2m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJaM2l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 08:28:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55520233;
        Mon, 31 Oct 2022 05:28:40 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id o8so8218086qvw.5;
        Mon, 31 Oct 2022 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3bnmf/0ztyUpSdZLRbUrr6EnxUTErY+h3YdktXzr/8=;
        b=a9eGIp0b/CmTbhtEZWCyaQPTkSivtOLLQCtojRDDy+diYechk5CIpDIc1USa6OcYhn
         FDTlnoXjk2Fe5xMI/zYCvvxSHJH0HdlIYG/KYhtBjdd9jToPcVxZIiIHRD0vNkAswUPp
         Df7UzAvgtwVgAL40pSY7jf0dCYgu93j6aPjytPRZWYuyVexFlJzL/LjEc6PEgunv/6xI
         MqV7CfbKhKYqkMpl5Kc863DSyN3kBcvgdAGd/2UG53ETjUQmSPrDoypG98mCLir6Dise
         4sCR1wHXveuguPsha8v7NcMOfD4OX7z5EgOjtNaNt6pjduYYfm5uWYK3W8g6KCsUG0u9
         YmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3bnmf/0ztyUpSdZLRbUrr6EnxUTErY+h3YdktXzr/8=;
        b=SkaCS3X/7MlGTU7my6QAaAZVGTxWj0GIzCzdmm683Pk2PTr8w8OLvtNtNh0lug0sYM
         HUhS/Tihv/d86M40BiGWNQSOA++p/tIQQ17zSts3DgVO3O+L0ZqaH0muO44qT+8gJ61e
         zUP3MIeRm4w+IfnpByLqmCtukK1OddRjbRt0yU0hJXLQWdJTD3B9VLjc61hx6dyoD6Qg
         uERpcq18RrjauZDRSaXXOAOw9QNesDS72bgDSfMCeVXT7tOiFKVsqJZb7Ha+eNYlamTC
         vnF0QHlghUhqatL240cHumHKHciMgmjbdPGCDXK74h2l+Fqstem2syLQDzo8yIaufH4F
         hNrg==
X-Gm-Message-State: ACrzQf1D5jVwP2o/cKPOvcwV9CM+a5KBSDsOmD/iXVP9oD2Xs4v9ZIYv
        UG8eXdAlZ1cT8vMb+wjYk7pZsLvIjtE=
X-Google-Smtp-Source: AMsMyM4EKNXLsZSEcP7h8dsZ8V7uOiuxgGBVarNBKEQULsTwj4YoySnkp+zqwe9+3mskRTbTmNOVew==
X-Received: by 2002:a0c:8e89:0:b0:4bb:62a2:b3cb with SMTP id x9-20020a0c8e89000000b004bb62a2b3cbmr10658597qvb.58.1667219319042;
        Mon, 31 Oct 2022 05:28:39 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id bs6-20020a05620a470600b006b61b2cb1d2sm4615460qkb.46.2022.10.31.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 05:28:38 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] Document BPF_MAP_TYPE_LPM_TRIE
In-Reply-To: <635c79e315b77_b1ba20836@john.notmuch> (John Fastabend's message
        of "Fri, 28 Oct 2022 17:54:59 -0700")
Date:   Mon, 31 Oct 2022 12:28:31 +0000
Message-ID: <m2v8o0yy6o.fsf@gmail.com>
References: <20221026100232.49181-1-donald.hunter@gmail.com>
        <635c79e315b77_b1ba20836@john.notmuch>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Donald Hunter wrote:
>> +
>> +Usage
>> +=====
>> +
>> +Kernel BPF
>> +----------
>> +
>> +.. c:function::
>> +   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
>> +
>> +The longest prefix entry for a given data value can be found using the
>> +``bpf_map_lookup_elem()`` helper. This helper returns a pointer to the
>> +value associated with the longest matching ``key``, or ``NULL`` if no
>> +entry was found.
>> +
>> +The ``key`` should have ``prefixlen`` set to ``max_prefixlen`` when
>> +performing longest prefix lookups. For example, when searching for the
>> +longest prefix match for an IPv4 address, ``prefixlen`` should be set to
>> +``32``.
>> +
>> +.. c:function::
>> +   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
>> +
>> +Prefix entries can be added or updated using the ``bpf_map_update_elem()``
>> +helper. This helper replaces existing elements atomically.
>> +
>> +``bpf_map_update_elem()`` returns ``0`` on success, or negative error in
>> +case of failure.
>> +
>> + .. note::
>> +    The flags parameter must be one of BPF_ANY, BPF_NOEXIST or BPF_EXIST,
>> +    but the value is ignored, giving BPF_ANY semantics.
>> +
>> +.. c:function::
>> +   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
>> +
>> +Prefix entries can be deleted using the ``bpf_map_delete_elem()``
>> +helper. This helper will return 0 on success, or negative error in case
>> +of failure.
>
> The map ops lookup, update, delete and below userspace are pretty generic to
> all map types. How about moving those into a generic file about maps? Maybe
> ./Documentation/bpf/mpas.rst? Then perhaps there is a way to link to
> them from here.

For the map types I have looked at so far, there has been a bit of
variation in semantics. E.g. array has u32 key does not support delete
and only supports update with BPF_EXIST/ANY, lpm_trie has custom keys
and specific lookup and iteration semantics. Hash has the most generic
semantics for get, lookup, update and delete. I am happy to add some
generic documentation about the ops in ./Documentation/bpf/maps.rst but
I think it will still be necessary to have specific documentation for
each map type where the op behaviour deviates. I'd prefer to keep the
map specific pages self-contained enough that a reader gets a clear view
of behaviour for both kernel BPF and userspace all in one place.

>> +
>> +Userspace
>> +---------
>> +
>> +Access from userspace uses libbpf APIs with the same names as above, with
>> +the map identified by ``fd``.
>> +
>> +.. c:function::
>> +   int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
>> +
>> +A userspace program can iterate through the entries in an LPM trie using
>> +libbpf's ``bpf_map_get_next_key()`` function. The first key can be
>> +fetched by calling ``bpf_map_get_next_key()`` with ``cur_key`` set to
>> +``NULL``. Subsequent calls will fetch the next key that follows the
>> +current key. ``bpf_map_get_next_key()`` returns ``0`` on success,
>> +``-ENOENT`` if cur_key is the last key in the hash, or negative error in
>> +case of failure.
>> +
>> +``bpf_map_get_next_key()`` will iterate through the LPM trie elements
>> +from leftmost leaf first. This means that iteration will return more
>> +specific keys before less specific ones.
>
> So I tihnk none of this is specific to LPM tries.
>
>> +
>> +Examples
>> +========
>> +
>> +Please see ``tools/samples/bpf/xdp_router_ipv4_user.c`` and
>
> I wouldn't link to samples. Can we link to a selftest? Maybe move the
> xdp_router_ipv4_user into a selftest otherwise no one ensures it is
> always working.

I will look for a suitable selftest that I can link to.

>> +``xdp_router_ipv4.bpf.c`` for a functional example. The code snippets
>> +below demonstrates API usage.
>> +
>> +Kernel BPF
>> +----------
>
> rest lgtm. Thanks for working on docs.
