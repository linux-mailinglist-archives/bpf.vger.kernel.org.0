Return-Path: <bpf+bounces-55784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC937A865F3
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 21:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8FE1BA6DC1
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134D27604D;
	Fri, 11 Apr 2025 19:12:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A4202C50;
	Fri, 11 Apr 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398756; cv=none; b=Qnxl30s4lGYGINZE30vwnZABagW0RX0qraN41LfQ/Wf+iiuV0X+f2BKWRpZcuE83psgAkrPjIbK9pHB1z0GWYP+fK0ju2N3NdWzUAZxJ6/1nd3hATTHwIOmstmLGRW7at/jfY13Ro/RROFK6GIWPZH7WqrYtZbFPCw3yJgKtkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398756; c=relaxed/simple;
	bh=T/5LdVwuMR1J602e4J3L93bEvRyZL9EqV+jkZH/D+wU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zq2wqUgsVDUQRT9E/4a4E0t7NcLT/HRhGgd41PL+2Jpg31n36XDwFRKdjM9qhofB8ynEz8Y1v+ORXmX/eWWR//JeNuYhlJ0Cea6rymjwMvgLsjTUdABZFSMVMIzgjtDAan104YYaGTv9qNwq22PaJXjKbWlIYeaqgDT163tC9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2302C4CEE2;
	Fri, 11 Apr 2025 19:12:33 +0000 (UTC)
Date: Fri, 11 Apr 2025 15:13:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250411151358.1d4fd8c7@gandalf.local.home>
In-Reply-To: <20250411143132.56096f76@gandalf.local.home>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
	<20250410131745.04c126eb@gandalf.local.home>
	<c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
	<20250411124552.36564a07@gandalf.local.home>
	<2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
	<20250411131254.3e6155ea@gandalf.local.home>
	<350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk>
	<9dafc156-1272-4039-a9c0-3448a1bd6d1f@sirena.org.uk>
	<20250411142427.3abfb3c3@gandalf.local.home>
	<20250411143132.56096f76@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 14:31:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, I just tested this, and it fails on my box too (I test on a debian V=
M).
>=20
> It fails with and without setting it to bash. I'll take a look too.

Hmm, maybe it is a bashism.

The test has this:

  # Max arguments limitation
  MAX_ARGS=3D128
  EXCEED_ARGS=3D$((MAX_ARGS + 1))

  check_max_args() { # event_header
    TEST_STRING=3D$1
    # Acceptable
    for i in `seq 1 $MAX_ARGS`; do
      TEST_STRING=3D"$TEST_STRING \\$i"
    done
    echo "$TEST_STRING" >> dynamic_events
    echo > dynamic_events
    # Error
    TEST_STRING=3D"$TEST_STRING \\$EXCEED_ARGS"
    ! echo "$TEST_STRING" >> dynamic_events
    return 0
  }

  # Kprobe max args limitation
  if grep -q "kprobe_events" README; then
    check_max_args "p vfs_read"
  fi

So I tried manually executing this in bash:

--------------------------8<--------------------------
# TEST_STRING=3D'p vfs_read'
# for i in `seq 1 128`; do TEST_STRING=3D"$TEST_STRING \\$i" ; done
# echo $TEST_STRING
p vfs_read \1 \2 \3 \4 \5 \6 \7 \8 \9 \10 \11 \12 \13 \14 \15 \16 \17 \18 \=
19 \20 \21 \22 \23 \24 \25 \26 \27 \28 \29 \30 \31 \32 \33 \34 \35 \36 \37 =
\38 \39 \40 \41 \42 \43 \44 \45 \46 \47 \48 \49 \50 \51 \52 \53 \54 \55 \56=
 \57 \58 \59 \60 \61 \62 \63 \64 \65 \66 \67 \68 \69 \70 \71 \72 \73 \74 \7=
5 \76 \77 \78 \79 \80 \81 \82 \83 \84 \85 \86 \87 \88 \89 \90 \91 \92 \93 \=
94 \95 \96 \97 \98 \99 \100 \101 \102 \103 \104 \105 \106 \107 \108 \109 \1=
10 \111 \112 \113 \114 \115 \116 \117 \118 \119 \120 \121 \122 \123 \124 \1=
25 \126 \127 \128
# echo "$TEST_STRING" >> /sys/kernel/tracing/dynamic_events
# echo $?
0
# cat /sys/kernel/tracing/dynamic_events
p:kprobes/p_vfs_read_0 vfs_read arg1=3D\1 arg2=3D\2 arg3=3D\3 arg4=3D\4 arg=
5=3D\5 arg6=3D\6 arg7=3D\7 arg8=3D\8 arg9=3D\9 arg10=3D\10 arg11=3D\11 arg1=
2=3D\12 arg13=3D\13 arg14=3D\14 arg15=3D\15 arg16=3D\16 arg17=3D\17 arg18=
=3D\18 arg19=3D\19 arg20=3D\20 arg21=3D\21 arg22=3D\22 arg23=3D\23 arg24=3D=
\24 arg25=3D\25 arg26=3D\26 arg27=3D\27 arg28=3D\28 arg29=3D\29 arg30=3D\30=
 arg31=3D\31 arg32=3D\32 arg33=3D\33 arg34=3D\34 arg35=3D\35 arg36=3D\36 ar=
g37=3D\37 arg38=3D\38 arg39=3D\39 arg40=3D\40 arg41=3D\41 arg42=3D\42 arg43=
=3D\43 arg44=3D\44 arg45=3D\45 arg46=3D\46 arg47=3D\47 arg48=3D\48 arg49=3D=
\49 arg50=3D\50 arg51=3D\51 arg52=3D\52 arg53=3D\53 arg54=3D\54 arg55=3D\55=
 arg56=3D\56 arg57=3D\57 arg58=3D\58 arg59=3D\59 arg60=3D\60 arg61=3D\61 ar=
g62=3D\62 arg63=3D\63 arg64=3D\64 arg65=3D\65 arg66=3D\66 arg67=3D\67 arg68=
=3D\68 arg69=3D\69 arg70=3D\70 arg71=3D\71 arg72=3D\72 arg73=3D\73 arg74=3D=
\74 arg75=3D\75 arg76=3D\76 arg77=3D\77 arg78=3D\78 arg79=3D\79 arg80=3D\80=
 arg81=3D\81 arg82=3D\82 arg83=3D\83 arg84=3D\84 arg85=3D\85 arg86=3D\86 ar=
g87=3D\87 arg88=3D\88 arg89=3D\89 arg90=3D\90 arg91=3D\91 arg92=3D\92 arg93=
=3D\93 arg94=3D\94 arg95=3D\95 arg96=3D\96 arg97=3D\97 arg98=3D\98 arg99=3D=
\99 arg100=3D\100 arg101=3D\101 arg102=3D\102 arg103=3D\103 arg104=3D\104 a=
rg105=3D\105 arg106=3D\106 arg107=3D\107 arg108=3D\108 arg109=3D\109 arg110=
=3D\110 arg111=3D\111 arg112=3D\112 arg113=3D\113 arg114=3D\114 arg115=3D\1=
15 arg116=3D\116 arg117=3D\117 arg118=3D\118 arg119=3D\119 arg120=3D\120 ar=
g121=3D\121 arg122=3D\122 arg123=3D\123 arg124=3D\124 arg125=3D\125 arg126=
=3D\126 arg127=3D\127 arg128=3D\128
-------------------------->8--------------------------

Doing the same in dash:

--------------------------8<--------------------------
# dash
# TEST_STRING=3D'p vfs_read'
# for i in `seq 1 128`; do TEST_STRING=3D"$TEST_STRING \\$i" ; done
# echo $TEST_STRING
p vfs_read         \8 \9 	=20
=20
 =20
   8 9         8 9   =E2=90=A6  9   ! " # $ % & ' 8 9 ( ) * + , - . / 8 9 0=
 1 2 3 4 5 6 7 8 9 8 9 : ; < =3D > ? 8 9 \80 \81 \82 \83 \84 \85 \86 \87 \8=
8 \89 \90 \91 \92 \93 \94 \95 \96 \97 \98 \99 @ A B C D E F G89 H I J K L M=
 N O 	8 	9 P Q R S T U V W=20
8
# echo "$TEST_STRING" >> /sys/kernel/tracing/dynamic_events
dash: 8: echo: echo: I/O error
-------------------------->8--------------------------

Looks like dash will translate those "\#" into the ASCII equivalent,
whereas bash does not.

This patch seems to fix it:

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limita=
tions.tc b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitati=
ons.tc
index 6b94b678741a..ebe2a34cbf92 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
@@ -11,7 +11,7 @@ check_max_args() { # event_header
   TEST_STRING=3D$1
   # Acceptable
   for i in `seq 1 $MAX_ARGS`; do
-    TEST_STRING=3D"$TEST_STRING \\$i"
+    TEST_STRING=3D"$TEST_STRING \\\\$i"
   done
   echo "$TEST_STRING" >> dynamic_events
   echo > dynamic_events


Masami, you just recently added this test (it's dated March 27th 2025), did
you mean to write in the ASCII characters? Why the backslash?

-- Steve

