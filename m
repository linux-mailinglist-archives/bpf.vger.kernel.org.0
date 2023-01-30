Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63895681D16
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 22:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjA3VpH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 16:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjA3VpF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 16:45:05 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A73591;
        Mon, 30 Jan 2023 13:44:45 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d3so13056164plr.10;
        Mon, 30 Jan 2023 13:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9S5F+SIi3K0A2CRSJbfNa++FiSrzn4hSVHAumvoZjgg=;
        b=VNIxqytIAFa/T/ycXc0B7/G1GtWJBIZL9nwN6W4yRZ2ksq5M4veKxyaFr/+BmCb+Ni
         OFGKMoGzA4RPZI4Ew+gzfEtm/8IJguPT/78CR2wIgekDtbUzt3kjkmbA1pTxfT4OsRJC
         yEhq52cmGLeYXFRbJatqeMG3FIu/b93JO2FDakTEo1V0Oufv28AMWueOK36cnapR9yDV
         CDekA1e1BZ7Sv7AQgUIKzmvQsJtpqS/Q493cxMOgkqB3uxf2BAlQ+FP+6R3esplw3+yo
         AfVmKz/FceweKX+/BGERqp4Rpaf1qWgvoL8y7MhMjIXjMEcCZx6fgKrLMD0Vos23yFlu
         bZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9S5F+SIi3K0A2CRSJbfNa++FiSrzn4hSVHAumvoZjgg=;
        b=JxkY0Iba9BUz3q+F9SXhpJhv+cgrSuF/bcnAFv/szYYtEOjXLNiws3VQSmJtxRiwvx
         zA93RaQrF1fpKvM7BZAdmGwQAlGq65byJWjVOhBm33RDyohtl0prsZaw0depXEK7/nQC
         LnMbbxdYFG8ivQ9v892t7rzeJVixkudqQaUrlhnFwZKHLVj9SdH5fqhHIDSQePzPARyW
         IviWVFVZoDS39cLIMrPN1+qMcZOy0Qi3M2QZi6QFWxh5GUmnLQWzzbsbncAmpLqMw+C0
         jlYXPhSMIhAKW+DAvQaBbwpeVgjZuPLUJuLuO7rEmwRmmYSckdez5iQB18rIwQsQNKY5
         GMog==
X-Gm-Message-State: AFqh2kr8MHxU7pOAThyAyo9eKyZYzGLvIUM7hT7rEYCgriwzDOZ/Hmmx
        ZUZCaa29A9ratJ2ZM7VdnA8=
X-Google-Smtp-Source: AMrXdXu/VvMbzIxptbQW+us/9hFwLEtjztOeQbW9++wfmk9ZrJpAZjUAQgaa2Ln9X+y1r+lS0pNeIw==
X-Received: by 2002:a05:6a20:9f95:b0:b9:478f:9720 with SMTP id mm21-20020a056a209f9500b000b9478f9720mr43981456pzb.42.1675115085178;
        Mon, 30 Jan 2023 13:44:45 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:a52d])
        by smtp.gmail.com with ESMTPSA id v64-20020a626143000000b00574ebfdc721sm8213850pfb.16.2023.01.30.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:44:44 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:44:42 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
        bpf@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [RFC] bpf: add bpf_link support for BPF_NETFILTER programs
Message-ID: <20230130214442.robf7ljttx5krjth@macbook-pro-6.dhcp.thefacebook.com>
References: <20230130150432.24924-1-fw@strlen.de>
 <87zg9zx6ro.fsf@toke.dk>
 <20230130180115.GB12902@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230130180115.GB12902@breakpoint.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 07:01:15PM +0100, Florian Westphal wrote:
> Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> > > Is BPF_LINK the right place?  Hook gets removed automatically if the calling program
> > > exits, afaict this is intended.

Yes. bpf_link is the right model.
I'd also allow more than one BPF_NETFILTER prog at the hook.
When Daniel respins his tc bpf_link set there will be a way to do that
for tc and hopefully soon for xdp.
For netfilter hook we can use the same approach.

> > 
> > Yes, this is indeed intended for bpf_link. This plays well with
> > applications that use the API and stick around (because things get
> > cleaned up after them automatically even if they crash, say), but it
> > doesn't work so well for programs that don't (which, notably, includes
> > command line utilities like 'nft').
> 
> Right, but I did not want to create a dependency on nfnetlink or
> nftables netlink right from the start.
> 
> > For XDP and TC users can choose between bpf_link and netlink for
> > attachment and get one of the two semantics (goes away on close or stays
> > put). Not sure if it would make sense to do the same for nftables?
> 
> For nftables I suspect that, if nft can emit bpf, it would make sense to
> pass the bpf descriptor together with nftables netlink, i.e. along with
> the normal netlink data.
> 
> nftables kernel side would then know to use the bpf prog for the
> datapath instead of the interpreter and could even fallback to
> interpreter.
> 
> But for the raw hook use case that Alexei and Daniel preferred (cf.
> initial proposal to call bpf progs from nf_tables interpreter) I think
> that there should be no nftables dependency.
> 
> I could add a new nfnetlink subtype for nf-bpf if bpf_link is not
> appropriate as an alternative.

Let's start with bpf_link and figure out netlink path when appropriate.

> > > Should a program running in init_netns be allowed to attach hooks in other netns too?
> > >
> > > I could do what BPF_LINK_TYPE_NETNS is doing and fetch net via
> > > get_net_ns_by_fd(attr->link_create.target_fd);
> > 
> > We don't allow that for any other type of BPF program; the expectation
> > is that the entity doing the attachment will move to the right ns first.
> > Is there any particular use case for doing something different for
> > nftables?
> 
> Nope, not at all.  I was just curious.  So no special handling for
> init_netns needed, good.
> 
> > > For the actual BPF_NETFILTER program type I plan to follow what the bpf
> > > flow dissector is doing, i.e. pretend prototype is
> > >
> > > func(struct __sk_buff *skb)
> > >
> > > but pass a custom program specific context struct on kernel side.
> > > Verifier will rewrite accesses as needed.
> > 
> > This sounds reasonable, and also promotes code reuse between program
> > types (say, you can write some BPF code to parse a packet and reuse it
> > between the flow dissector, TC and netfilter).
> 
> Ok, thanks.
> 
> > > Things like nf_hook_state->in (net_device) could then be exposed via
> > > kfuncs.
> > 
> > Right, so like:
> > 
> > state = bpf_nf_get_hook_state(ctx); ?
> > 
> > Sounds OK to me.
> 
> Yes, something like that.  Downside is that the nf_hook_state struct
> is no longer bound by any abi contract, but as I understood it thats
> fine.

I'd steer clear from new abi-s.
Don't look at uapi __sk_buff model. It's not a great example to follow.
Just pass kernel nf_hook_state into bpf prog and let program deal
with changes to it via CORE.
The prog will get a defition of 'struct nf_hook_state' from vmlinux.h
or via private 'struct nf_hook_state___flavor' with few fields defined
that prog wants to use. CORE will deal with offset adjustments.
That's a lot less kernel code. No need for asm style ctx rewrites.
Just see how much kernel code we already burned on *convert_ctx_access().
We cannot remove this tech debt due to uapi.
When you pass struct nf_hook_state directly none of it is needed.
