Return-Path: <bpf+bounces-15679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B657F4EE9
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02BF281390
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6ED58AB6;
	Wed, 22 Nov 2023 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oau+khQa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D547B2
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:05:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ce4e0e2bdso32764276.3
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700676337; x=1701281137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rLGzr2RwpR7u2JJS1qUA9AQ9iJQ3KxhhH8GvvtmAwY=;
        b=Oau+khQaF+bnBUhdYBNIfeXCgdP93isQpEoxWZcy8GcZT2ojD1bTP2PNn2RoBC4McH
         OM5qlRduyoS8yfXPoA2d7qGN6Y0e0ewtyNShoDz4RuYuoJSBtr5rSvLYfC3BMNEZqgzq
         9CyWKJ6xsqzl5KwDCFVYNkPtigHYh21VQ6JwZ+EaO11I5fA8fwqlSyj8AwwPBh9t7IST
         8JZLEEdWYlITc/tdjdapkh0iQQrzXXA4qCE74z4Ds+iUNgF+Lk1Qsg8L6gP5M+odkn96
         +8Jv/Qh1abCuoVDDrNWKcCkFr21gnNoQuMzplHz3fcSNIZSuexDY76/3ngL3i3q+TdWG
         RIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676337; x=1701281137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rLGzr2RwpR7u2JJS1qUA9AQ9iJQ3KxhhH8GvvtmAwY=;
        b=NFgASf7ioi60fvEvOpGjdWekG1TBUqynCExI38+uZ1eLS4lYeeVUTEu9b0PtVW1v71
         Tp+s+EVgAx7HuyXJvqcqW5IRMBZhkMXObABLUzYAdQE9oPFswYfd+zGNP0kQZJbSme+C
         wU+Lmh304qLtZfLQlylbJ4cYLYHN3hJoNroGmcp52sJ85QQcrxdIOyWAw+wUJnucBCs6
         hEc4OJ3A/CKSDhdcaO9wbeL4ZrjqwptbrlDcrYU13pA02gcy9yoj+Z8Y4NUaCursYKnw
         JO3KIjufGIpceZuFtbuXUyV8ftfz+w6qB/27X2Ky9yEVmFPK0PHbfkosqE94j7K9nu6S
         eBzQ==
X-Gm-Message-State: AOJu0YzGa0qjtJUdnHrAQ7Tiaf/sxPU1rhYJfq1jA0pcfH2z4t6w5Rvv
	tHj7hZCA5VZNcTaINAp/EAnCBwA=
X-Google-Smtp-Source: AGHT+IEi6rx5HdAmblcgb3pSvcyJd6i+t9+j+spXNk9UPPt1M3L2tpTF82haI295T4NsMAwrCh+AJRk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:aa52:0:b0:db4:7ac:fea6 with SMTP id
 s76-20020a25aa52000000b00db407acfea6mr64505ybi.7.1700676336797; Wed, 22 Nov
 2023 10:05:36 -0800 (PST)
Date: Wed, 22 Nov 2023 10:05:35 -0800
In-Reply-To: <b4854a4b-a692-8164-5684-4315939966f3@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231114045453.1816995-1-sdf@google.com> <20231114045453.1816995-3-sdf@google.com>
 <49538852-1ca0-49bb-86c2-cb1b95739b91@linux.dev> <b4854a4b-a692-8164-5684-4315939966f3@iogearbox.net>
Message-ID: <ZV5C7099HylvusQO@google.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: bring back removal of dev-bound id from idr
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org, andrii@kernel.org, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 11/22, Daniel Borkmann wrote:
> On 11/21/23 10:03 PM, Martin KaFai Lau wrote:
> > On 11/13/23 8:54 PM, Stanislav Fomichev wrote:
> > > Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
> > > and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
> > > idr when the offloaded/bound netdev goes away. I was supposed to
> > > take a look and check in [0], but apparently I did not.
> > > 
> > > The purpose of idr removal is to avoid BPF_PROG_GET_NEXT_ID returning
> > > stale ids for the programs that have a dead netdev. This functionality
> > 
> > What may be wrong if BPF_PROG_GET_NEXT_ID returns the id?
> > e.g. If the prog is pinned somewhere, it may be useful to know a prog is still loaded in the system.

bpftool is a bit spooked by those prog ids currently: calling GET_INFO_BY_ID
on those programs returns ENODEV. So we can keep those ids around, but
need some tweaks on the bpftool in this case. LMK if any of you prefer
this option.

> Wouldn't this strictly speaking provide an invalid id (== 0) upon unload
> back to audit - see the bpf_audit_prog(prog, BPF_AUDIT_UNLOAD) call location?

Removing from idr shouldn't affect bpf_audit_prog, right? bpf_audit_prog
is using prog->aux->id for its purposes, so as long as we are not resetting
this value - we're good.

