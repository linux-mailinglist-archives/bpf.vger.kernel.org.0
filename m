Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B85844B7
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiG1RLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiG1RLi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 13:11:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5DE5B78A
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:11:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a89so2974972edf.5
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=LKk5RGYFeq00DvpKb3lnykV6+ilWY2M4WOTpODRi18g=;
        b=DmhA2/Acnh63XyR0u/Dx++psBECaaVFxk75SrwbM1b50rEuaaRQFmziBAxUqw18n2f
         F3rzV7NAYlC96jO04k1z+GEC3C/YyBZkxl5NBxlvc4aWk2a0Bp8/RTecMcIPHv/6DT3J
         e+dRtM1bJahmKlElkV9Naq41DKbgoSLk/vqSUERJ6L+K86z1muOHaU3LyjU1AA7216Yt
         abhDIEigFZ0v5uvTEkT/ZBme8Wl/10xGM18J8efOzKR+2bh7pSfOROCPiOgHcm+dwCsI
         73yNQvI7t5qs+9E6BXWpSDdiV0hxLIwg7NgkIUXNn46z0k++CXflUTtNAQmTxYBwhOJ6
         zHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=LKk5RGYFeq00DvpKb3lnykV6+ilWY2M4WOTpODRi18g=;
        b=x1MRh0LUCQYgxPpMldNVET1IFY0dil0Y7tQh34V5BTqfOcel1YDr7Ot53kbYdtWuhh
         LyZ2fyJsPhrDqft1lciU0mHS3J1W0+lIkHKcyk40u0M4bx5aAqJ/5VeeNLAnzk3hfFeC
         3IXFNIK8RHtVnrn0e/2XbIsncoFjKlmAcUogmB6SewRBqWZO8Bf8SbJ4dQTsI8+Qvvxr
         9lkcwTtG9bBVkP2lPPC5VKcCp5IuuHoGLPKAsUdKQ7lLVH9lRAWLNdJUeQIvc9zG6VQr
         XUMeu6cc8y2jyAWghOvSTMm9/7ry0BMjuLmc9Nk6ogbNOh5yt0GYxojE0i6ObCgZaAQI
         wPvA==
X-Gm-Message-State: AJIora8aV+82IUr1UJopneTpjCURTKRfFQKZNmITPM82VL23Xgd5iVui
        WOR+0ucCi5/i7zT6+tuXR5wwq6FfqW3cOb43qoFo6lTZ
X-Google-Smtp-Source: AGRyM1sm5rYdDWfnWimT3x9gEvYJmsqVNgr95PbGPo3GLzJouQg92kq566nFs3vwY24D3vZTlZGHGrK4BM8TeFcxBg8=
X-Received: by 2002:aa7:d6d0:0:b0:43b:c997:25da with SMTP id
 x16-20020aa7d6d0000000b0043bc99725damr28823219edr.224.1659028295348; Thu, 28
 Jul 2022 10:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <OBzRUbPFxraCqyqKJG4wxt16KtWfSZuzR1_huzK30nTPOyc2_oKjBYylXc9fr0CL_oOi0SbH8P67jujAXcI8rMT_wZQwfcAblzuteWLv5fg=@pm.me>
 <CAEf4Bzb=-gRPao8cTj3iJs0fGaXT_F1AzYNn8A5apuHCGZJPpw@mail.gmail.com> <1yMmLyw6DIUWbp5FKL9iEyXrHURGP486VDX7zOgdTsJ5MG75eRMV6-MapdXAqut0HmLu3Fm26a0R2IH3UawocwlzsBCGVpvZXVuw1WIssCc=@pm.me>
In-Reply-To: <1yMmLyw6DIUWbp5FKL9iEyXrHURGP486VDX7zOgdTsJ5MG75eRMV6-MapdXAqut0HmLu3Fm26a0R2IH3UawocwlzsBCGVpvZXVuw1WIssCc=@pm.me>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Jul 2022 10:11:24 -0700
Message-ID: <CAEf4BzbAam4m3vgoGzg4NxWTUi8=i5uFy4tDVj9Ud2dYwDTOqA@mail.gmail.com>
Subject: Re: What happens to a uprobe if it links to a library within a
 container, and that container gets deleted?
To:     Yadunandan Pillai <thesw4rm@pm.me>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 18, 2022 at 2:00 PM Yadunandan Pillai <thesw4rm@pm.me> wrote:
>
> > uprobe BPF program attached to perf_event object; this attachment
> (link) also has associated FD (for older kernels you'll have only
> perf_event FD, though);
>
> Will there be two FDs in the newer kernel, in that case? One for the perf=
_event object itself and one for the link between the uprobe to the perf ev=
ent object.

yes

>
> And how exactly does the uprobe attach to a specific symbol (like a funct=
ion) within a shared library? Does it basically hook itself into a pre-calc=
ulated offset? What happens if the code at that offset is edited while the =
uprobe is attached?

yes (about offset), I don't know about the second one, but all the
source code is openly available (plus you can always experiment)


>
>
>
>
>
>
>
>
>
> Yadunandan Pillai
>
>
> ------- Original Message -------
> On Monday, July 11th, 2022 at 11:27 PM, Andrii Nakryiko <andrii.nakryiko@=
gmail.com> wrote:
>
>
> > On Thu, Jul 7, 2022 at 12:05 PM
> >
> > Yadunandan Pillai
> >
> > thesw4rm@pm.me wrote:
> >
> > > How are uprobes "remembered" in the kernel from a conceptual standpoi=
nt? Where is the attach point stored? Is it basically a hashmap with JMP in=
structions for each function that is being attached to? What exactly does t=
he cleanup process look like if the attach point disappears?
> > >
> > > Example of a use case: let's say a uprobe is to "SSL_read" in /proc/[=
root_pid]/root/.../libssl.so where [root_pid] is the root process of a cont=
ainer. If the container dies, then does that uprobe hang around attaching t=
o empty air or gets deleted as well?
> >
> >
> > In BPF world, uprobe is a combination of two objects, each having
> > their FD and associated lifetimes:
> > - perf_event_open() syscall creates perf_event kernel object that
> > represents uprobe itself (you specify target binary, which kernel
> > resolves into inode internally; optionally you also specify PID
> > filter, so uprobe can be triggered only for specific process or for
> > all processes that run code from specified binary);
> > - uprobe BPF program attached to perf_event object; this attachment
> > (link) also has associated FD (for older kernels you'll have only
> > perf_event FD, though);
> >
> > As long as at least one of those FDs are not closed, your uprobe+BPF
> > program will be active. They might not be triggered ever because file
> > was deleted from file system (I think file's inode will be kept around
> > until perf_event is destroyed, but I haven't checked the code).
> >
> > So direct answer to your last question depends on what happens with
> > perf_event that was created during attachment. If its FD survives the
> > container (because you transferred FD, or the process is outside of
> > container, or you pinned BPF link representing that attachment), then
> > no, uprobe is still there. But if the process that attached BPF
> > program exits and nothing else keeps FD alive, then BPF program and
> > perf_event will be detached and destroyed.
> >
> > > Yadunandan Pillai
