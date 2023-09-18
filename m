Return-Path: <bpf+bounces-10299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD327A4DBC
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2659A282818
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA4D20B29;
	Mon, 18 Sep 2023 15:55:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B31F95D;
	Mon, 18 Sep 2023 15:55:38 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA610D0;
	Mon, 18 Sep 2023 08:54:27 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1d544a4a315so3020032fac.3;
        Mon, 18 Sep 2023 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695052210; x=1695657010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61snCKe06KPtK8SZFvfz/MMgI8Hd2GlUCK6N97LWobM=;
        b=aAsBq0m6J+VzutsMpV30BVv5d1+lbdIJcstgS+f2tfC7WZH9+67GAW7FtohbIswlXu
         qW6pvF2Exl8f93VklFOxlAMrrW2fh7sur+hcKOSU5zOHWXnjLGfjjGSAe+5CL9RPeT4A
         g/6YCHVDbx9KsyyEIyW7LPFKUqXSyahvZ5K/E5LLZxbVd2vQCPvGwas1Ox0EIjSW+n2a
         wIvbD90ALLxBdhLiM4xr9hZ2M9ddv97i8Vw+e3uGp07fAKHiyomVdNEyv0hGAwmu/fWs
         LF4gjiG5APBRK0v/lEzS79d4ozPtxtW7oE6WDhhGySJ8W8ToLz7x6EvgdU5oegUHgo9+
         RpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052210; x=1695657010;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=61snCKe06KPtK8SZFvfz/MMgI8Hd2GlUCK6N97LWobM=;
        b=KYmm+CTvmopQy3X8MOAa52HOn/l4b54KvEtvSvz/CtLTbjC5hklPqPjniB7fjv4XKY
         46Rmosj0TIw6oDX6i4g34gTT820bNV9fy/3rLUu/Sg8Tm0gh3Wun4wiRYjWC/dQDoFU3
         n/Jp9czNGTU8NOSlG8dYkEqNf5PeqC3cEyF+YvgFR5uvY2MYHOX/jcZCYwoSqE+1br43
         9D68JLTiOLiP3t448iVtC7SFqOKyOW4GabePOYut1HP+/QXZZk7ePOq+I1LSPx4XgSrN
         C8fsDgjDImVaywdQ9G8DNNHw8CitrbSASfALvRmJF2NjsOM6FG5m9BEPGBNjPyd4A4v7
         PY3g==
X-Gm-Message-State: AOJu0Yxiht7rcxM/J5NGiVUHkkWzbwkwpSAkKLMIt7CmKGviXkpy1H2k
	50TCxdZE+1eQPAa8dAPPvASLZA0edwJ8pw==
X-Google-Smtp-Source: AGHT+IEzx/KVZBPGz2VbExUWiBpA46W8imxgXBV2iRh0gYXZXb1hNpFROGMdgbEmKHjxz+ijKNaF3w==
X-Received: by 2002:a67:eb98:0:b0:44d:e70d:8a4b with SMTP id e24-20020a67eb98000000b0044de70d8a4bmr6951497vso.8.1695045481946;
        Mon, 18 Sep 2023 06:58:01 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id r11-20020a0ce28b000000b00646e0411e8csm1833490qvl.30.2023.09.18.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 06:58:01 -0700 (PDT)
Date: Mon, 18 Sep 2023 09:58:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Howells <dhowells@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: dhowells@redhat.com, 
 syzbot <syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com>, 
 bpf@vger.kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 syzkaller-bugs@googlegroups.com
Message-ID: <65085768c17da_898cd294ae@willemb.c.googlers.com.notmuch>
In-Reply-To: <3905046.1695031382@warthog.procyon.org.uk>
References: <3793723.1694795079@warthog.procyon.org.uk>
 <CANn89iLwMhOnrmQTZJ+BqZJSbJZ+Q4W6xRknAAr+uSrk5TX-EQ@mail.gmail.com>
 <0000000000001c12b30605378ce8@google.com>
 <3905046.1695031382@warthog.procyon.org.uk>
Subject: Re: [syzbot] [net?] WARNING in __ip6_append_data
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > I think the attached is probably an equivalent cleaned up reproducer.  Note
> > that if the length given to sendfile() is less than 65536, it fails with
> > EINVAL before it gets into __ip6_append_data().
> 
> Actually, it only fails with EINVAL if the size is not a multiple of the block
> size of the source file because it's open O_DIRECT so, say, 65536-512 is fine
> (and works).
> 
> But thinking more on this further, is this even a bug in my code, I wonder?
> The length passed is 65536 - but a UDP packet can't carry that, so it
> shouldn't it have errored out before getting that far?  (which is what it
> seems to do when I try it).
> 
> I don't see how we get past the length check in ip6_append_data() with the
> reproducer we're given unless the MTU is somewhat bigger than 65536 (is that
> even possible?)

An ipv6 packet can carry 64KB of payload, so maxnonfragsize of 65535 + 40
sounds correct. But payload length passed of 65536 is not (ignoring ipv6
jumbograms). So that should probably trigger an EINVAL -- if that is indeed
what the repro does.



