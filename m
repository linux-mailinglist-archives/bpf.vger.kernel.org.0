Return-Path: <bpf+bounces-47700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370F19FE9EF
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 19:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669573A2AA0
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707D183CD9;
	Mon, 30 Dec 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqHTd2cO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F1EAD0;
	Mon, 30 Dec 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583826; cv=none; b=StMvNFtyBWo1nex4y8a6Y85dRfX+vq25ZBZIlxUQz3leusMAFGbMqa+ISu7PAip3EfgB+m3/TMqWGtbsgiXJ+kpz2VzeOxyaTJcSBCtULtLeieG6Vb3681ChCAMf4/47QYeYpbc9Rw4nGTG+3NJ0TbBu2uO5u1bojI5uuo5O6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583826; c=relaxed/simple;
	bh=EANVJ2/f+m7Ra8zRZ0RgWEPJuaQL9QikhE9kQv3f5yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcEDQUiLsuaR6fR47lk74tVPOwa4PXqbCX+5JCBmQX01ELBVMFr/dJw9PVDAI8JRYrhja8A5fGCm66cjI1qaZbrdvUz06JXJSVKmqjX9O3vDrx0ygtSzcSQBOJ89y7I8r8a2+qqLSw5rbyjcVftpoGge3S/w1wRoMlZDcKtuL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqHTd2cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A68FC4CED0;
	Mon, 30 Dec 2024 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735583826;
	bh=EANVJ2/f+m7Ra8zRZ0RgWEPJuaQL9QikhE9kQv3f5yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqHTd2cOXXsjcX/HfdyTZvUrH/NrtpY0wQ3thdL5K0+peBu5BWTForsEvVqWDt1Mj
	 GnSl1GxCM5wPC6qv5MhS7u+1f0s+eSHxjCHD0EPTQ0vuoPcPi5BZM1xQjZcKVRizpS
	 WCX+0rtxRJCHjfZdIVC+gplKp65KTMV5Twn44rMkO4xs106JuGGtXHR2mkH4QqgH7E
	 cwRhZl/DibJFRcdg2GQmzPqdyHgVHsaF5umlyjsj0PHZr2AWS5LumglHhNsZ4o025z
	 6L9gAxyb6XwmdW62GA7MU4VNUUHQa3kDQsSMFhHg443nGpQIuX/Rf0gRrlsNeTujkL
	 hp9WOXmib/l4g==
Date: Mon, 30 Dec 2024 15:37:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com,
	andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 7/8] dwarf_loader: multithreading with a
 job/worker model
Message-ID: <Z3LoTvt7PtUAbh5K@x1>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
 <20241221012245.243845-8-ihor.solodrai@pm.me>
 <Z3LFREHG-8QhoAcc@x1>
 <Z3LGOXGgK1Qx1zW-@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3LGOXGgK1Qx1zW-@x1>

On Mon, Dec 30, 2024 at 01:11:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > Not really :-\
> > 
> > root@number:/home/acme/git/pahole# pfunct --decl_info -F dwarf evtchn_fifo_is_pending /lib/modules/6.13.0-rc2/build/vmlinux
> > /* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c */
> > /* <946502e> /home/acme/git/linux/drivers/xen/events/events_fifo.c:206 */
> > bool evtchn_fifo_is_pending(evtchn_port_t port);
> > /* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c */
> > /* <946502e> /home/acme/git/linux/drivers/xen/events/events_fifo.c:206 */
> > bool evtchn_fifo_is_pending(evtchn_port_t port);
> > root@number:/home/acme/git/pahole#
> > 
> > So far I couldn't find an explanation for this oddity... Lets see if
> > after applying all patches we get past this.
 
> Its not related to this patch series, before we get two outputs for
> these (and other functions in
> /home/acme/git/linux/drivers/xen/events/events_fifo.c).
> 
> Still investigating.

root@number:/home/acme/git/pahole# perf probe -x ~/bin/pfunct function__show
Added new event:
  probe_pfunct:function_show (on function__show in /home/acme/git/pahole/build/pfunct)

You can now use it in all perf tools, such as:

	perf record -e probe_pfunct:function_show -aR sleep 1

root@number:/home/acme/git/pahole# perf trace -e probe_pfunct:function_show --call-graph dwarf pfunct --decl_info -F dwarf evtchn_fifo_set_pending /lib/modules/6.13.0-rc2/build/vmlinux
/* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c */
/* <946517a> /home/acme/git/linux/drivers/xen/events/events_fifo.c:200 */
void evtchn_fifo_set_pending(evtchn_port_t port);
/* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c */
/* <946517a> /home/acme/git/linux/drivers/xen/events/events_fifo.c:200 */
void evtchn_fifo_set_pending(evtchn_port_t port);
     0.000 pfunct/2006089 probe_pfunct:function_show(__probe_ip: 4208235)
                                       function__show (/home/acme/git/pahole/build/pfunct)
                                       pfunct_stealer (/home/acme/git/pahole/build/pfunct)
                                       cus__steal_now (/home/acme/git/pahole/build/libdwarves.so.1.0.0)
                                       dwarf_loader__worker_thread (/home/acme/git/pahole/build/libdwarves.so.1.0.0)
                                       start_thread (/usr/lib64/libc.so.6)
                                       clone3 (/usr/lib64/libc.so.6)
     0.134 pfunct/2006088 probe_pfunct:function_show(__probe_ip: 4208235)
                                       function__show (/home/acme/git/pahole/build/pfunct)
                                       cu_function_iterator (/home/acme/git/pahole/build/pfunct)
                                       cus__for_each_cu (/home/acme/git/pahole/build/libdwarves.so.1.0.0)
                                       main (/home/acme/git/pahole/build/pfunct)
                                       __libc_start_call_main (/usr/lib64/libc.so.6)
                                       __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
                                       _start (/home/acme/git/pahole/build/pfunct)
root@number:/home/acme/git/pahole#

With the following patch we get just one output for this case, but that
isn't the right solution... I'll look on removing the
cu_function_iterator() based printing, otherwise when printing all
matches we'll still duplicate the printings.

Anyway, doesn't seem related to the problem that tests/tests was
catching, that I'm not being able to reproduce anymore after having the
whole series applied, probably some race?

- Arnaldo

diff --git a/pfunct.c b/pfunct.c
index 55eafe8a8e790dcb..9645b004381a7e1e 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -518,7 +518,13 @@ static enum load_steal_kind pfunct_stealer(struct cu *cu,
 
 		if (tag) {
 			function__show(tag__function(tag), cu);
-			return show_all_matches ? LSK__DELETE : LSK__STOP_LOADING;
+			if (!show_all_matches) {
+				// Expedite exit, since we already did what was requested:
+				// print the first occurrence of a given function
+				exit(0);
+			}
+
+			return LSK__DELETE;
 		}
 	} else if (class_name) {
 		cu_class_iterator(cu, class_name);


