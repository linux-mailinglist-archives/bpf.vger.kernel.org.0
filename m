Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC25A1DCB
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 02:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiHZArN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 20:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiHZArM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 20:47:12 -0400
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 17:47:11 PDT
Received: from frotz.zork.net (frotz.zork.net [69.164.197.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF8C7FBF;
        Thu, 25 Aug 2022 17:47:11 -0700 (PDT)
Received: by frotz.zork.net (Postfix, from userid 1008)
        id 5364213265E9; Fri, 26 Aug 2022 00:45:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 frotz.zork.net 5364213265E9
Date:   Thu, 25 Aug 2022 17:45:52 -0700
From:   Seth David Schoen <schoen@loyalty.org>
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        bpf <bpf@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] Fit line in 80 columns
Message-ID: <20220826004552.GM2831600@frotz.zork.net>
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
 <20220825225425.hp2ylp5rxq453ewl@illithid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825225425.hp2ylp5rxq453ewl@illithid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

G. Branden Robinson writes:

> If someone got a contract with O'Reilly or No Starch Press to write a
> book on BPF and how revolutionarily awesome it is, it's conceivable they
> would be faced with exposing some BPF-related function declarations in
> the text.  In cases like the following, what would you have them do?
> 
> int bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)

I imagine that the author or editor would break it over two lines like

int bpf_map_update_elem(struct bpf_map *map, const void *key,
                        const void *value, u64 flags)

or maybe the slightly uglier

int bpf_map_update_elem(struct bpf_map *map, const void *key,
    const void *value, u64 flags)

I just looked in _Advanced Programming in the Unix Environment, Third
Edition_ by Stevens and Rago (published by Addison Wesley rather than
either of the fine publishers you mentioned), and it didn't take long
to find a C function prototype that was split across two lines in the
former style, on p. 880

sem_t     *sem_open(const char *name, int oflag, ... /* mode_t mode,
                    unsigned int value */ );

... or on the next page, a better example because of the absence of the
comment:

ssize_t    sendto(int sockfd, const void *buf, size_t nbytes, int flags,
                  const struct sockaddr *destaddr, socklen_t destlen);

It's convenient that C's rules for whitespace semantics make all of
these line-wrapped prototypes have exactly the same meaning as their
un-line-wrapped equivalents, so programmers reading the books shouldn't
have cause to be confused by this.  It could be more challenging in a
language like Python, although there, too, there are syntactically
valid ways to break up some kinds of long lines.
