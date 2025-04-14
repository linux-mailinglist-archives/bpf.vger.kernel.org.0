Return-Path: <bpf+bounces-55833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F548A87616
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 05:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522C57A6A1C
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 03:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EECC1990D8;
	Mon, 14 Apr 2025 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMaZkW8c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C21953AD;
	Mon, 14 Apr 2025 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744600142; cv=none; b=Drwh4EUCfE7aeT4MuGvfe9I0R3m8FyMTEuMR/1TVcjKYrmMtsUmgpelAnEfrHrnioyIyK08lCs9H82nKxm+vFxxRcybBGRfwEAoBxTnegkeheQzNXvl8e8bCImAojwu3coNXtJyeWG0ny9AkozRsNmn9x29l4HgvJRSCcYZ7qPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744600142; c=relaxed/simple;
	bh=g7wafSBCYLabX41Qp9oGHFXOid7epq0wqGnZyAyGK4Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aKtNqd5zDJ2NTuYX6GSegQ3uRiH+bqH11xKkPbAE78iniWbq1zcFRid2pYpmHee38XkJNU8c/HJn+B2shgxHK/a1pZYtYetn4jsBix9/cK2sPbsqk/oGnWUcWVfRf1aNSzx0NPT6pgwR7Hm/o6nhwRE942zvC1pO/xWBRXJwaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMaZkW8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C8DC4CEDD;
	Mon, 14 Apr 2025 03:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744600142;
	bh=g7wafSBCYLabX41Qp9oGHFXOid7epq0wqGnZyAyGK4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMaZkW8cG8zb0rXc8EQvuTKQGyDDPwrftGnN5vzXYBwB/RsaivHlpKBUt6MIUOBLH
	 VfgRbu1imzTIe6VvtUk3ZHsWW/UgWZpQa2sYlbRh25oA9z5okRxw6rKYJnW3YybAjp
	 oUUByWppBw8t6S48uzTI7bX19NWpazxKZkYCC5h1/Z7CFkyBNVy7s8qxR56OEVFows
	 68wPpMN+Y4QvXkymvxaUpEf/AmbmShOTVGIriYg2ewg6qWDtE/nj46TYOg0HMsEhRE
	 /AHPXxPVfCYJ7yoNbDaiAWXrKhmbp9Lf12OLfavvO/CtK1RDpm7nfvWZ57hNhgoMh3
	 FlMf3jl1DTMnQ==
Date: Mon, 14 Apr 2025 12:08:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Donglin
 Peng <dolinux.peng@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>,
 Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-Id: <20250414120858.0cda755e37a68537a8ae5b67@kernel.org>
In-Reply-To: <20250411151358.1d4fd8c7@gandalf.local.home>
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
	<20250411151358.1d4fd8c7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 15:13:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 11 Apr 2025 14:31:32 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hmm, I just tested this, and it fails on my box too (I test on a debian VM).
> > 
> > It fails with and without setting it to bash. I'll take a look too.
> 
> Hmm, maybe it is a bashism.
> 
> The test has this:
> 
>   # Max arguments limitation
>   MAX_ARGS=128
>   EXCEED_ARGS=$((MAX_ARGS + 1))
> 
>   check_max_args() { # event_header
>     TEST_STRING=$1
>     # Acceptable
>     for i in `seq 1 $MAX_ARGS`; do
>       TEST_STRING="$TEST_STRING \\$i"
>     done
>     echo "$TEST_STRING" >> dynamic_events
>     echo > dynamic_events
>     # Error
>     TEST_STRING="$TEST_STRING \\$EXCEED_ARGS"
>     ! echo "$TEST_STRING" >> dynamic_events
>     return 0
>   }
> 
>   # Kprobe max args limitation
>   if grep -q "kprobe_events" README; then
>     check_max_args "p vfs_read"
>   fi
> 
> So I tried manually executing this in bash:
> 
> --------------------------8<--------------------------
> # TEST_STRING='p vfs_read'
> # for i in `seq 1 128`; do TEST_STRING="$TEST_STRING \\$i" ; done
> # echo $TEST_STRING
> p vfs_read \1 \2 \3 \4 \5 \6 \7 \8 \9 \10 \11 \12 \13 \14 \15 \16 \17 \18 \19 \20 \21 \22 \23 \24 \25 \26 \27 \28 \29 \30 \31 \32 \33 \34 \35 \36 \37 \38 \39 \40 \41 \42 \43 \44 \45 \46 \47 \48 \49 \50 \51 \52 \53 \54 \55 \56 \57 \58 \59 \60 \61 \62 \63 \64 \65 \66 \67 \68 \69 \70 \71 \72 \73 \74 \75 \76 \77 \78 \79 \80 \81 \82 \83 \84 \85 \86 \87 \88 \89 \90 \91 \92 \93 \94 \95 \96 \97 \98 \99 \100 \101 \102 \103 \104 \105 \106 \107 \108 \109 \110 \111 \112 \113 \114 \115 \116 \117 \118 \119 \120 \121 \122 \123 \124 \125 \126 \127 \128
> # echo "$TEST_STRING" >> /sys/kernel/tracing/dynamic_events
> # echo $?
> 0
> # cat /sys/kernel/tracing/dynamic_events
> p:kprobes/p_vfs_read_0 vfs_read arg1=\1 arg2=\2 arg3=\3 arg4=\4 arg5=\5 arg6=\6 arg7=\7 arg8=\8 arg9=\9 arg10=\10 arg11=\11 arg12=\12 arg13=\13 arg14=\14 arg15=\15 arg16=\16 arg17=\17 arg18=\18 arg19=\19 arg20=\20 arg21=\21 arg22=\22 arg23=\23 arg24=\24 arg25=\25 arg26=\26 arg27=\27 arg28=\28 arg29=\29 arg30=\30 arg31=\31 arg32=\32 arg33=\33 arg34=\34 arg35=\35 arg36=\36 arg37=\37 arg38=\38 arg39=\39 arg40=\40 arg41=\41 arg42=\42 arg43=\43 arg44=\44 arg45=\45 arg46=\46 arg47=\47 arg48=\48 arg49=\49 arg50=\50 arg51=\51 arg52=\52 arg53=\53 arg54=\54 arg55=\55 arg56=\56 arg57=\57 arg58=\58 arg59=\59 arg60=\60 arg61=\61 arg62=\62 arg63=\63 arg64=\64 arg65=\65 arg66=\66 arg67=\67 arg68=\68 arg69=\69 arg70=\70 arg71=\71 arg72=\72 arg73=\73 arg74=\74 arg75=\75 arg76=\76 arg77=\77 arg78=\78 arg79=\79 arg80=\80 arg81=\81 arg82=\82 arg83=\83 arg84=\84 arg85=\85 arg86=\86 arg87=\87 arg88=\88 arg89=\89 arg90=\90 arg91=\91 arg92=\92 arg93=\93 arg94=\94 arg95=\95 arg96=\96 arg97=\97 arg98=\98 ar
 g99=\99 arg100=\100 arg101=\101 arg102=\102 arg103=\103 arg104=\104 arg105=\105 arg106=\106 arg107=\107 arg108=\108 arg109=\109 arg110=\110 arg111=\111 arg112=\112 arg113=\113 arg114=\114 arg115=\115 arg116=\116 arg117=\117 arg118=\118 arg119=\119 arg120=\120 arg121=\121 arg122=\122 arg123=\123 arg124=\124 arg125=\125 arg126=\126 arg127=\127 arg128=\128
> -------------------------->8--------------------------
> 
> Doing the same in dash:
> 
> --------------------------8<--------------------------
> # dash
> # TEST_STRING='p vfs_read'
> # for i in `seq 1 128`; do TEST_STRING="$TEST_STRING \\$i" ; done
> # echo $TEST_STRING
> p vfs_read         \8 \9 	 
>  
>   
>    8 9         8 9   ␦  9   ! " # $ % & ' 8 9 ( ) * + , - . / 8 9 0 1 2 3 4 5 6 7 8 9 8 9 : ; < = > ? 8 9 \80 \81 \82 \83 \84 \85 \86 \87 \88 \89 \90 \91 \92 \93 \94 \95 \96 \97 \98 \99 @ A B C D E F G89 H I J K L M N O 	8 	9 P Q R S T U V W 
> 8
> # echo "$TEST_STRING" >> /sys/kernel/tracing/dynamic_events
> dash: 8: echo: echo: I/O error
> -------------------------->8--------------------------

Oops...

> 
> Looks like dash will translate those "\#" into the ASCII equivalent,
> whereas bash does not.

Ah, I didn't know that.

> 
> This patch seems to fix it:
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> index 6b94b678741a..ebe2a34cbf92 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> @@ -11,7 +11,7 @@ check_max_args() { # event_header
>    TEST_STRING=$1
>    # Acceptable
>    for i in `seq 1 $MAX_ARGS`; do
> -    TEST_STRING="$TEST_STRING \\$i"
> +    TEST_STRING="$TEST_STRING \\\\$i"
>    done
>    echo "$TEST_STRING" >> dynamic_events
>    echo > dynamic_events
> 
> 
> Masami, you just recently added this test (it's dated March 27th 2025), did
> you mean to write in the ASCII characters? Why the backslash?

No, the kprobe_event accepts raw digit values to record in the trace buffer
which is for the probe points which uses a fixed digit value for the actual
local variable (or function parameter), e.g. constant propagation with
optimized function instances.

In this case, can we use below?

TEST_STRING="$TEST_STRING "'\\'$i


Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

