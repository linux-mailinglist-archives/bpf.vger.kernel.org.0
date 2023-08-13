Return-Path: <bpf+bounces-7666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B404F77A478
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 03:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE6D280F9E
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 01:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E8310ED;
	Sun, 13 Aug 2023 01:01:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24C7E;
	Sun, 13 Aug 2023 01:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E45EC433C7;
	Sun, 13 Aug 2023 01:01:42 +0000 (UTC)
Date: Sat, 12 Aug 2023 21:01:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheao Li <me@manjusaka.me>
Cc: edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, Joe
 Perches <joe@perches.com>
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230812210140.117da558@rorschach.local.home>
In-Reply-To: <20230812205905.016106c0@rorschach.local.home>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
	<20230812201249.62237-1-me@manjusaka.me>
	<20230812205905.016106c0@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Aug 2023 20:59:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Aug 2023 20:12:50 +0000
> Zheao Li <me@manjusaka.me> wrote:
> 
> > +TRACE_EVENT(tcp_ca_event,
> > +
> > +	TP_PROTO(struct sock *sk, const u8 ca_event),
> > +
> > +	TP_ARGS(sk, ca_event),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(const void *, skaddr)
> > +		__field(__u16, sport)
> > +		__field(__u16, dport)
> > +		__field(__u16, family)
> > +		__array(__u8, saddr, 4)
> > +		__array(__u8, daddr, 4)
> > +		__array(__u8, saddr_v6, 16)
> > +		__array(__u8, daddr_v6, 16)
> > +		__field(__u8, ca_event)  
> 
> Please DO NOT LISTEN TO CHECKPATCH!
> 
> The above looks horrendous! Put it back to:
> 
> > +		__field(	const void *,	skaddr			)
> > +		__field(	__u16,		sport			)
> > +		__field(	__u16,		dport			)
> > +		__field(	__u16,		family			)
> > +		__array(	__u8,		saddr,		4	)
> > +		__array(	__u8,		daddr,		4	)
> > +		__array(	__u8,		saddr_v6,	16	)
> > +		__array(	__u8,		daddr_v6,	16	)
> > +		__field(	__u8,		ca_event		)  
> 
> See how much better it looks I can see fields this way.
> 
> The "checkpatch" way is a condensed mess.
> 

The below patch makes checkpatch not complain about some of this. But
there's still more to do.

-- Steve

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a52..24df11e8c861 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -73,6 +73,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
+my $trace_macros = "__array|__dynamic_array|__field|__string|EMe?";
 
 sub help {
 	my ($exitcode) = @_;
@@ -5387,7 +5388,8 @@ sub process {
 
 # check spacing on parentheses
 		if ($line =~ /\(\s/ && $line !~ /\(\s*(?:\\)?$/ &&
-		    $line !~ /for\s*\(\s+;/) {
+		    $line !~ /for\s*\(\s+;/ &&
+		    $line !~ m/$trace_macros/) {
 			if (ERROR("SPACING",
 				  "space prohibited after that open parenthesis '('\n" . $herecurr) &&
 			    $fix) {
@@ -5397,7 +5399,8 @@ sub process {
 		}
 		if ($line =~ /(\s+)\)/ && $line !~ /^.\s*\)/ &&
 		    $line !~ /for\s*\(.*;\s+\)/ &&
-		    $line !~ /:\s+\)/) {
+		    $line !~ /:\s+\)/ &&
+		    $line !~ m/$trace_macros/) {
 			if (ERROR("SPACING",
 				  "space prohibited before that close parenthesis ')'\n" . $herecurr) &&
 			    $fix) {
@@ -5906,6 +5909,7 @@ sub process {
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
 			    $dstat !~ /^for\s*$Constant\s+(?:$Ident|-?$Constant)$/ &&	# for (...) bar()
 			    $dstat !~ /^do\s*{/ &&					# do {...
+			    $dstat !~ /^EMe?\s*1u/ &&					# EM( and EMe( are commonly used with TRACE_DEFINE_ENUM
 			    $dstat !~ /^\(\{/ &&						# ({...
 			    $ctx !~ /^.\s*#\s*define\s+TRACE_(?:SYSTEM|INCLUDE_FILE|INCLUDE_PATH)\b/)
 			{
@@ -6017,7 +6021,8 @@ sub process {
 					WARN("DO_WHILE_MACRO_WITH_TRAILING_SEMICOLON",
 					     "do {} while (0) macros should not be semicolon terminated\n" . "$herectx");
 				}
-			} elsif ($dstat =~ /^\+\s*#\s*define\s+$Ident.*;\s*$/) {
+			} elsif ($dstat =~ /^\+\s*#\s*define\s+$Ident.*;\s*$/ &&
+				 $dstat !~ /TRACE_DEFINE_ENUM\(/) {
 				$ctx =~ s/\n*$//;
 				my $cnt = statement_rawlines($ctx);
 				my $herectx = get_stat_here($linenr, $cnt, $here);

