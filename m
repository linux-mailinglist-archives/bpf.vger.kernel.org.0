Return-Path: <bpf+bounces-5376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD5F759DEB
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9001C21179
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77454275C8;
	Wed, 19 Jul 2023 18:44:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49400275A1
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 18:44:26 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9A9D;
	Wed, 19 Jul 2023 11:44:24 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 32245A037B;
	Wed, 19 Jul 2023 18:44:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 4C90117;
	Wed, 19 Jul 2023 18:44:18 +0000 (UTC)
Message-ID: <67766eb5a995634e001b842fe988a423cf3d0eab.camel@perches.com>
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
From: Joe Perches <joe@perches.com>
To: paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
  rostedt@goodmis.org, Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Date: Wed, 19 Jul 2023 11:44:17 -0700
In-Reply-To: <351d0261-210a-44a3-ade6-59289f407db2@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
	 <20230717180454.1097714-5-paulmck@kernel.org>
	 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
	 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
	 <a0f6e131-a649-1731-b096-46313a0460a9@joelfernandes.org>
	 <351d0261-210a-44a3-ade6-59289f407db2@paulmck-laptop>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4C90117
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: ftxe36kuiqofqtn78eri53x5qiwaae5c
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX197GdII1dUBVk1hNyCI5ovl0ED8+iGgAYk=
X-HE-Tag: 1689792258-611757
X-HE-Meta: U2FsdGVkX1+/1d61TKZjaJ5v+F++hdzvR7Ws20jch90gHlih17kSgk/71ZQXWxwtY5tIZnhiNM9PcSr8bYM+isOKT7EjvDUdjnEF7OG6qPkVKBzOKIh7AR+r72pRazYmG4NH6VJCsR1pPg3D33tjZvHhktcFELioyjbR83sSx4j91+/dgsWFSamlVYRoJg0bY9r1ujqzY/U7uJo+Nn8SO30u4J2qEp/ldJlA/vTE/ITJC1arBkRLndpSHOQNhCrIf/BtgtmyhkMkATTOLD7XPORathsgJNeu/9YR9P125IGqPcCJcDrQPGNzAVYRiFDH
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-19 at 11:27 -0700, Paul E. McKenney wrote:
[]
> > > >=20
> Given perl's tendency to have corner cases in its corner cases, I
> am guessing that the "^" character combined with the "/" character is
> causing trouble here.  Especially given that I don't see any use of such
> a pattern anywhere in checkpatch.pl except directly in a "~" expression,
> and there are a lot of those.
>=20
> So I will keep it as is unless I hear otherwise from Joe Perches.

I played with it a bit and can't think of anything better.

Code is always something that can be improved later so the
way Paul has it now is fine with me.

