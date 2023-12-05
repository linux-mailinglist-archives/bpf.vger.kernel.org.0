Return-Path: <bpf+bounces-16789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F60805FBF
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D892C281F84
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886996A02F;
	Tue,  5 Dec 2023 20:50:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A46DD1B;
	Tue,  5 Dec 2023 20:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF43CC433C7;
	Tue,  5 Dec 2023 20:50:08 +0000 (UTC)
Date: Tue, 5 Dec 2023 15:50:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, hengqi@linux.alibaba.com, Philo Lu
 <lulie@linux.alibaba.com>
Subject: Re: [PATCH net-next] tcp: add tracepoints for data send/recv/acked
Message-ID: <20231205155035.6dd41a13@gandalf.local.home>
In-Reply-To: <CANn89i+Xs3sSDQcub9p=YGUp1_XainGQpS=0RVpYTiDjvRN1rw@mail.gmail.com>
References: <20231204114322.9218-1-lulie@linux.alibaba.com>
	<CANn89iKUHQHA2wHw9k1SiazJf7ag7i4Tz+FPutgu870teVw_Bg@mail.gmail.com>
	<1701740897.6795166-1-xuanzhuo@linux.alibaba.com>
	<CANn89i+Xs3sSDQcub9p=YGUp1_XainGQpS=0RVpYTiDjvRN1rw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 20:39:28 +0100
Eric Dumazet <edumazet@google.com> wrote:

> > So, we do not want to add some tracepoint to do some unknow debug.
> > We have a clear goal. debugging is just an incidental capability.
> >  
> 
> We have powerful mechanisms in the stack already that ordinary (no
> privilege requested) applications can readily use.
>

I'm not arguing for or against this patch set, but tracepoints are
available for other utilities that may have non privilege access. They are
not just for tracers.

-- Steve

