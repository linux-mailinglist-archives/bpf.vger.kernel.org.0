Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAAB578C4C
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 23:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiGRVAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 17:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGRVAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 17:00:14 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC131228
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 14:00:13 -0700 (PDT)
Date:   Mon, 18 Jul 2022 21:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1658178008; x=1658437208;
        bh=22fCo9Ol6krQR4PVVJkemZsps6aK4jWf/9iGf4avj04=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=VARkgDl39lKwAwt2oquVs0bzoPsDT+6WOQOIeqwpeksygTwQ5O87W2nPsLHxe5Rx4
         nMW0cLn4H1Eu0nxx+YVRn+3jl96FD0dhcW++GBa7KWSDigK+8GCK7aA/EG9obwTaqs
         3zN59oLF/4DOODIVXreFcC19aIi0JWbq5G68AVIVvDavn/Nykg2dPbVYkaBPh30DEk
         SZl8S2TXJgS2ZgwQwZy+FskOujR34yKHA8vvaYpecVITjUGozQ0aUY51+XCvCIsf7r
         kFQ4ExJ3GZ05Ap0DVXYMYIvLdevJbrMWaDLTxvMNmv3FB53EDc49H+na4ffTyrAy71
         +RquESa3yHh4A==
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
From:   Yadunandan Pillai <thesw4rm@pm.me>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Reply-To: Yadunandan Pillai <thesw4rm@pm.me>
Subject: Re: What happens to a uprobe if it links to a library within a container, and that container gets deleted?
Message-ID: <1yMmLyw6DIUWbp5FKL9iEyXrHURGP486VDX7zOgdTsJ5MG75eRMV6-MapdXAqut0HmLu3Fm26a0R2IH3UawocwlzsBCGVpvZXVuw1WIssCc=@pm.me>
In-Reply-To: <CAEf4Bzb=-gRPao8cTj3iJs0fGaXT_F1AzYNn8A5apuHCGZJPpw@mail.gmail.com>
References: <OBzRUbPFxraCqyqKJG4wxt16KtWfSZuzR1_huzK30nTPOyc2_oKjBYylXc9fr0CL_oOi0SbH8P67jujAXcI8rMT_wZQwfcAblzuteWLv5fg=@pm.me> <CAEf4Bzb=-gRPao8cTj3iJs0fGaXT_F1AzYNn8A5apuHCGZJPpw@mail.gmail.com>
Feedback-ID: 11923722:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> uprobe BPF program attached to perf_event object; this attachment
(link) also has associated FD (for older kernels you'll have only
perf_event FD, though);

Will there be two FDs in the newer kernel, in that case? One for the perf_e=
vent object itself and one for the link between the uprobe to the perf even=
t object.

And how exactly does the uprobe attach to a specific symbol (like a functio=
n) within a shared library? Does it basically hook itself into a pre-calcul=
ated offset? What happens if the code at that offset is edited while the up=
robe is attached?









Yadunandan Pillai


------- Original Message -------
On Monday, July 11th, 2022 at 11:27 PM, Andrii Nakryiko <andrii.nakryiko@gm=
ail.com> wrote:


> On Thu, Jul 7, 2022 at 12:05 PM
>
> Yadunandan Pillai
>
> thesw4rm@pm.me wrote:
>
> > How are uprobes "remembered" in the kernel from a conceptual standpoint=
? Where is the attach point stored? Is it basically a hashmap with JMP inst=
ructions for each function that is being attached to? What exactly does the=
 cleanup process look like if the attach point disappears?
> >
> > Example of a use case: let's say a uprobe is to "SSL_read" in /proc/[ro=
ot_pid]/root/.../libssl.so where [root_pid] is the root process of a contai=
ner. If the container dies, then does that uprobe hang around attaching to =
empty air or gets deleted as well?
>
>
> In BPF world, uprobe is a combination of two objects, each having
> their FD and associated lifetimes:
> - perf_event_open() syscall creates perf_event kernel object that
> represents uprobe itself (you specify target binary, which kernel
> resolves into inode internally; optionally you also specify PID
> filter, so uprobe can be triggered only for specific process or for
> all processes that run code from specified binary);
> - uprobe BPF program attached to perf_event object; this attachment
> (link) also has associated FD (for older kernels you'll have only
> perf_event FD, though);
>
> As long as at least one of those FDs are not closed, your uprobe+BPF
> program will be active. They might not be triggered ever because file
> was deleted from file system (I think file's inode will be kept around
> until perf_event is destroyed, but I haven't checked the code).
>
> So direct answer to your last question depends on what happens with
> perf_event that was created during attachment. If its FD survives the
> container (because you transferred FD, or the process is outside of
> container, or you pinned BPF link representing that attachment), then
> no, uprobe is still there. But if the process that attached BPF
> program exits and nothing else keeps FD alive, then BPF program and
> perf_event will be detached and destroyed.
>
> > Yadunandan Pillai
