Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5D43371C
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhJSNej (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 09:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235804AbhJSNec (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 09:34:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484C160ED3;
        Tue, 19 Oct 2021 13:32:18 +0000 (UTC)
Date:   Tue, 19 Oct 2021 09:32:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <20211019093216.058ec98b@gandalf.local.home>
In-Reply-To: <YW7HfV9+UiuYxt7N@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
        <20211008091336.33616-8-jolsa@kernel.org>
        <20211014162819.5c85618b@gandalf.local.home>
        <YWluhdDMfkNGwlhz@krava>
        <20211015100509.78d4fb01@gandalf.local.home>
        <YWq6C69rQhUcAGe+@krava>
        <20211018221015.3f145843@gandalf.local.home>
        <YW7F8kTc3Bl8AkVx@krava>
        <YW7HfV9+UiuYxt7N@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 19 Oct 2021 15:26:21 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> > when trying to apply on top of my changes  
> 
> I updated my ftrace/direct branch, it actually still had the previous
> version.. sorry, perhaps this is the cause of fuzz

I just pushed it (including your patches) here:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

  ftrace/core


This is where I keep my WIP code. It should not be used to base anything
off of, as I rebase it constantly. But it has the current version I plan on
testing.

You can make sure the patches in there have your latest version, as you can
review my patch. I'll update the tags if you give me one.

-- Steve
