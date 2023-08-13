Return-Path: <bpf+bounces-7670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753BF77A49B
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 04:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E40280F97
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882751118;
	Sun, 13 Aug 2023 02:08:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5D7E;
	Sun, 13 Aug 2023 02:08:29 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572CB4;
	Sat, 12 Aug 2023 19:08:27 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 2925114040F;
	Sun, 13 Aug 2023 02:08:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id A38016000F;
	Sun, 13 Aug 2023 02:08:21 +0000 (UTC)
Message-ID: <a587dac9e02cfde669743fd54ab41a3c6014c5e9.camel@perches.com>
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
From: Joe Perches <joe@perches.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zheao Li <me@manjusaka.me>, edumazet@google.com, bpf@vger.kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Date: Sat, 12 Aug 2023 19:08:20 -0700
In-Reply-To: <20230812215327.1dbd30f3@rorschach.local.home>
References: 
	<CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
	 <20230812201249.62237-1-me@manjusaka.me>
	 <20230812205905.016106c0@rorschach.local.home>
	 <20230812210140.117da558@rorschach.local.home>
	 <20230812210450.53464a78@rorschach.local.home>
	 <6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
	 <20230812215327.1dbd30f3@rorschach.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A38016000F
X-Stat-Signature: 3k674k5cyum391tkwztpyf6dighwktqn
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+BdS2QWQ7CIyNzWx+BfWch9SSUrvtweNk=
X-HE-Tag: 1691892501-986183
X-HE-Meta: U2FsdGVkX182cJZYs5TTbpuQUYTU8mHjC5KKOJSgqmulNzf/BICLAZ8euaXCM5soosuO+b1scqkNGYRwVuXEzRzlpi8cGffeI3CX5kG4aSTIe0zpDYkJQjar/Q9031i6fECnVUYg+juGws/mF6V6SKrFQu8bwXzl4WEEZ0LDSUJBjndwE5wSY/0yYBX4hHreRjJdj3seZX9VVLlouyQLP//IHyNYgDrv5hgdY4bAxQmBysF8RuPhm3kRkRfJ73d+9w2HUT+R1+YlYerbNotl3H+Z89sfLvDQkyqW0ZovCMSJtzuzUGHpUeQDFT2v5XYj6rapjWQazKtyxv9961n4a8HugqcWNPugjzm+v4u3VE3kJIdE1ns4uW85xOHGwDZe
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-08-12 at 21:53 -0400, Steven Rostedt wrote:
> On Sat, 12 Aug 2023 18:17:17 -0700
> Joe Perches <joe@perches.com> wrote:
>=20
> > > I forgot to say "for TRACE_EVENT() macros". This is not about what
> > > checkpatch says about other code. =20
> >=20
> > trace has its own code style and checkpatch needs another
> > parsing mechanism just for it, including the alignment to
> > open parenthesis test.
>=20
> If you have a template patch to add the parsing mechanism, I'd be happy
> to try to fill in the style.

There is no checkpatch mechanism per se.  It's all ad-hoc.

Perhaps something like this though would work well enough
as it just avoids all the other spacing checks and such.
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 528f619520eb9..3017f4dd09fd2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3947,6 +3947,9 @@ sub process {
 			}
 		}
=20
+# trace include files use a completely different grammar
+		next if ($realfile =3D~ m{(?:include/trace/events/|/trace\.h$/)});
+
 # check multi-line statement indentation matches previous line
 		if ($perl_version_ok &&
 		    $prevline =3D~ /^\+([ \t]*)((?:$c90_Keywords(?:\s+if)\s*)|(?:$Declar=
e\s*)?(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*|(?:\*\s*)*$Lval\s*=3D\s*$Ident\s*=
)\(.*(\&\&|\|\||,)\s*$/) {




