Return-Path: <bpf+bounces-833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0E2707661
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 01:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3765528113A
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 23:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EADB2A9D7;
	Wed, 17 May 2023 23:25:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775C2A9C0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 23:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C3FC433D2;
	Wed, 17 May 2023 23:25:29 +0000 (UTC)
Date: Wed, 17 May 2023 19:25:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, David Vernet <void@manifault.com>,
 dthaler@microsoft.com, brauner@kernel.org, hch@infradead.org
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230517192528.043adc7a@gandalf.local.home>
In-Reply-To: <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
References: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
	<CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
	<20230516222919.79bba667@rorschach.local.home>
	<CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
	<20230517172243.GA152@W11-BEAU-MD.localdomain>
	<CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
	<20230517190750.GA366@W11-BEAU-MD.localdomain>
	<CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
	<CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
	<CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
	<20230517230054.GA195@W11-BEAU-MD.localdomain>
	<CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 May 2023 16:14:43 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, May 17, 2023 at 4:01=E2=80=AFPM Beau Belgrave <beaub@linux.micros=
oft.com> wrote:
> >
> > Do you mind giving me your Signed-off-by for these? =20
>=20
> Assuming you have some test-cases that you've run them through, then yes:

Beau,

Can you update the tools/testing/selftests/user_events/ to make sure that
it triggers the lockdep splat without these updates (assuming that it does
trigger without these patches). Then add these patches to make sure the
splat goes away. This will confirm that the patches do what is expected of
them.

I usually run the selftests for tracing and for your user events with
lockdep and prove locking enabled. But it may have triggered on something
else disabling it when I ran my tests, in which case I sometimes disable
that and forget to re-enable it.

-- Steve

