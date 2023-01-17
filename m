Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891B166D3AE
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 01:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjAQAlm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 19:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjAQAll (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 19:41:41 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA00621A3A
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 16:41:39 -0800 (PST)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHa2b-0003ow-3s; Tue, 17 Jan 2023 01:41:29 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHa2a-000Pr8-Jk; Tue, 17 Jan 2023 01:41:28 +0100
Subject: Re: [RFC PATCH bpf-next] Documentation/bpf: Add a description of
 "stable kfuncs"
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     David Vernet <void@manifault.com>, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20230116225724.377099-1-toke@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6deb800f-57d8-9ee5-d588-ee6354e74aa9@iogearbox.net>
Date:   Tue, 17 Jan 2023 01:41:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230116225724.377099-1-toke@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26783/Mon Jan 16 09:28:30 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/16/23 11:57 PM, Toke Høiland-Jørgensen wrote:
> Following up on the discussion at the BPF office hours, this patch adds a
> description of the (new) concept of "stable kfuncs", which are kfuncs that
> offer a "more stable" interface than what we have now, but is still not
> part of UAPI.
> 
> This is mostly meant as a straw man proposal to focus discussions around
> stability guarantees. From the discussion, it seemed clear that there were
> at least some people (myself included) who felt that there needs to be some
> way to export functionality that we consider "stable" (in the sense of
> "applications can rely on its continuing existence").
> 
> One option is to keep BPF helpers as the stable interface and implement
> some technical solution for moving functionality from kfuncs to helpers
> once it has stood the test of time and we're comfortable committing to it
> as a stable API. Another is to freeze the helper definitions, and instead
> use kfuncs for this purpose as well, by marking a subset of them as
> "stable" in some way. Or we can do both and have multiple levels of "stable",
> I suppose.
> 
> This patch is an attempt to describe what the "stable kfuncs" idea might look
> like, as well as to formulate some criteria for what we mean by "stable", and
> describe an explicit deprecation procedure. Feel free to critique any part
> of this (including rejecting the notion entirely).
> 
> Some people mentioned (in the office hours) that should we decide to go in
> this direction, there's some work that needs to be done in libbpf (and
> probably the kernel too?) to bring the kfunc developer experience up to par
> with helpers. Things like exporting kfunc definitions to vmlinux.h (to make
> them discoverable), and having CO-RE support for using them, etc. I kinda
> consider that orthogonal to what's described here, but I added a
> placeholder reference indicating that this (TBD) functionality exists.

Thanks for the writeup.. I did some edits to your sections to make some parts
more clear and to leave out other parts (e.g. libbpf-related bits which are not
relevant in here and it's one of many libs). I also edited some parts to leave
us more flexibility. Here would be my take mixed in:


3. API (in)stability of kfuncs
==============================

By default, kfuncs exported to BPF programs are considered a kernel-internal
interface that can change between kernel versions. In the extreme case that
could also include removal of a kfunc. This means that BPF programs using
kfuncs might need to adapt to changes between kernel versions. In other words,
kfuncs are _not_ part of the kernel UAPI! Rather, these kfuncs can be thought
of as being similar to internal kernel API functions exported using the
``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionality must
initially start out as kfuncs.

3.1 Promotion to "stable"
-------------------------

While kfuncs are by default considered unstable as described above, some kfuncs
may warrant a stronger stability guarantee and could be marked as *stable*. The
decision to move a kfunc to *stable* is taken on a case-by-case basis and has
a high barrier, taking into account its usefulness under longer-term production
deployment without any unforeseen API issues or limitations. In general, it is
not expected that every kfunc will turn into a stable one - think of it as an
exception rather than the norm. kfuncs which have been promoted to stable are
then marked using the ``KF_STABLE`` tag. The possibility from a stable kfunc to
a BPF helper addition is up to the maintainers to decide.

1. Stable kfuncs will not change their function signature or functionality in
    a way that may cause incompatibilities for BPF programs calling the function.

2. The BPF community will make every reasonable effort to keep stable kfuncs
    around as long as they continue to be useful to real-world BPF applications.

3. Should a stable kfunc turn out to be no longer useful, a deprecation procedure
    might be implemented for them as outlined below.

3.2 Deprecation of kfuncs
-------------------------

As described above, the community will make every reasonable effort to keep
kfuncs available through future kernel versions once they are marked as stable.
However, there may be the unforeseen case that BPF development moves in a
direction where even a stable kfunc is no longer useful for program development.
In this case, stable kfuncs can be marked as *deprecated* using the
``KF_DEPRECATED`` tag. Such deprecation request cannot be arbitrary and must
explain why a given stable kfunc should be deprecated.

1. A deprecated stable kfunc will be kept in the kernel for a conservatively
    chosen period of time after it got first marked as deprecated (usually
    corresponding to a span of multiple years).

2. Deprecated functions will be documented in the kernel docs along with their
    remaining lifespan and including a recommendation for new functionality that
    can replace the usage of the deprecated function (or an explanation for why
    no such replacement exists).

3. After the deprecation period, the kfunc will be removed and the function name
    will be marked as invalid inside the kernel (to ensure that no new kfunc is
    accidentally introduced with the same name in the future). After this
    happens, BPF programs calling the kfunc will be refused by the verifier.


Thanks,
Daniel
