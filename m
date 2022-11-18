Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431C162F146
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 10:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbiKRJeI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 04:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiKRJeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 04:34:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3097C74E;
        Fri, 18 Nov 2022 01:33:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so3117561wma.1;
        Fri, 18 Nov 2022 01:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zItZ9cjLCKNwbVcWqZT2DVpSg2RkBqa93OmXRyt9amM=;
        b=V0Jn1xrOE5ElkZ2kYpJp2yRxQ8CtenJf11LAQqL9pFAo9IPewTZ8XguM0b8G/0BhuQ
         TCTG6HT90fz1exqyoZm7qPt8i6TW6Q9QEZLSVURJT2al2soZpOuM1VK9Go4i75u28Bpe
         U5cx2sSdwVSxUlH+HLtn647z4X0AANTFlxc6i4gim9nXN7TGFVksVWFftqmTAu0gUFS+
         /Jy4YaZSDgMj2ENLUJDd/nGhBdU/EW1QdLJGTHyCT9H6I3mcHGXYAmCGDsNUputEWbQi
         qNskaWf8qUt3epIg9c67c9AXkg/eAv7FMyQx0UkpdPDzrhx0+aveGr57AoBGyBmVHtAG
         VKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zItZ9cjLCKNwbVcWqZT2DVpSg2RkBqa93OmXRyt9amM=;
        b=ql3eqxKIHFWhCT/B/vOWPJYLDXA5nC1wzJWCgZYDaDHpt40IgCyCEx2N5mWeOTZ2SP
         A7/Tl8XmJ/lIThF9qIQNzmv9b3ZmeY3CLWDEN39XApEhnXCBCEXVcy0VVtxSpsDuWDU9
         xwR3vOUqvcdhb131WFMRjn34Jd9aqaGAbfPLn66WFGN0HHei4uyWZ8Cm+jC+8He2xrlF
         DlwpVzhyri660VD4L5cO63s6UHkhSWgzHSGZgRc7crAbkM2ndSV4WBCgsz0nkZ8QFZ61
         +WyyNXqDTrBDbtaZab5dvSAjgwowgDaTlFYBn6BTyZwlS4SaOJTtNgr6RDPfDySxD7iv
         KUZg==
X-Gm-Message-State: ANoB5pmr+0aY6IoIgbdeDY9BATta5gOdlLS66IANlBm6Zzjh1p+1mrfG
        aNnngTmbnpk4UYta9I21wsU=
X-Google-Smtp-Source: AA0mqf7CmdV6z3FuaOw/dSV47sa3iGW71bUKaMq+GRV7QaUr982l97wvigtNDQTuYjz0+GzaArM5hA==
X-Received: by 2002:a05:600c:1604:b0:3cf:7fb1:e217 with SMTP id m4-20020a05600c160400b003cf7fb1e217mr4342349wmn.92.1668764036538;
        Fri, 18 Nov 2022 01:33:56 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:51ad:9be7:a084:1016])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d6943000000b002383e977920sm3068675wrw.110.2022.11.18.01.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:33:55 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     mtahhan@redhat.com, bpf@vger.kernel.org, donhunte@redhat.com,
        jbrouer@redhat.com, linux-doc@vger.kernel.org,
        magnus.karlsson@gmail.com, thoiland@redhat.com
Subject: Re: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_XSKMAP
In-Reply-To: <8d4899f1-fcd2-edc6-31da-363b13f8049b@gmail.com> (Akira
        Yokosawa's message of "Fri, 18 Nov 2022 11:36:30 +0900")
Date:   Fri, 18 Nov 2022 09:33:21 +0000
Message-ID: <m24juwy5cu.fsf@gmail.com>
References: <20221117154446.3684330-1-mtahhan@redhat.com>
        <8d4899f1-fcd2-edc6-31da-363b13f8049b@gmail.com>
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

Akira Yokosawa <akiyks@gmail.com> writes:
>
> So you have two declarations of bpf_map_lookup_elem() in map_xskmap.rst.
>
> This will cause "make htmldocs" with Sphinx >=3.1 to emit a warning of:
>
> /linux/Documentation/bpf/map_xskmap.rst:100: WARNING: Duplicate C declaration, also defined at map_xskmap:71.
> Declaration is '.. c:function:: int bpf_map_lookup_elem(int fd, const void *key, void *value)'.
>
> , in addition to a bunch of similar warnings observed at bpf-next:
>
> /linux/Documentation/bpf/map_cpumap.rst:50: WARNING: Duplicate C declaration, also defined at map_array:43.
> Declaration is '.. c:function:: int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);'.
> /linux/Documentation/bpf/map_cpumap.rst:72: WARNING: Duplicate C declaration, also defined at map_array:35.
> Declaration is '.. c:function:: int bpf_map_lookup_elem(int fd, const void *key, void *value);'.
> /linux/Documentation/bpf/map_hash.rst:37: WARNING: Duplicate C declaration, also defined at map_array:43.
> Declaration is '.. c:function:: long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)'.
> ... [bunch of similar warnings]

That's unfortunate, and I'm responsible for some of those. Not sure how
we'd know to check for warnings with Sphinx >= 3.1 when
Documentation/doc-guide/sphinx.rst and
Documentation/sphinx/requirements.txt both specify version 2.4.4

> You might want to say you don't care, but they would annoy those
> who do test "make htmldocs".
>
> So let me explain why sphinx complains.
>
> C domain declarations in kernel documentation are for kernel APIs.
> By default, c:function declarations belong to the top-level namespace,
> which is intended for kernel APIs.
>
> IIUC, most APIs described in map*.rst files don't belong to kernel.
> So I think the way to go is to use the c:namespace directive.
>
> See: https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#namespacing
>
> As mentioned there, namespacing works with Sphinx >=3.1.
> Currently, kernel documentation build scripts support only the
> "c:namespace" directive, which means you can't switch namespaces in the
> middle of a .rst file. This limitation comes from the fact that Sphinx
> 1.7.9 is still in the list for htmldocs at the moment and build scripts
> emulate namespacing for Sphinx <3.1 in a limited way.

What's the reason for keeping support for Sphinx 1.7.9 and pinning to
2.4.4 in Documentation/sphinx/requirements.txt if we want to support
Sphinx >= 3.1? Given that the latest Sphinx release is 5.3.0, and Python
2 support was dropped in Sphinx 2.0.0 it seems that we need to have a
higher minimum version and a higher default version.

> So please avoid putting function declarations of the same name in
> a .rst file.

The same function name, with different signature gets used as a BPF
helper and as a userspace function. We'd really like to be able to
document the semantics of both for a given BPF map type, all on the same
page.

Is there a better way for us to highlight the function signature,
without using the c:function:: directive, since they're not really
function declarations?

> The other duplicate warnings shown above can be silenced by the
> change attached below. It is only as a suggestion and I'm not putting
> a S-o-b tag.
>
> Hope this helps,
>
> Akira
