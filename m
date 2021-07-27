Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431F33D71AE
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhG0JEh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhG0JEg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 05:04:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3FEC061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ysBHCS9QquzqSbDrTHkDKch7Sjkc/RzIohS03Z0gHh8=; b=ArzM+yjamKhAaRnUVcIeynB2cD
        hOM+rE1VQ126RhXgu8gEHFmjdLMF2CdzjeqALbUhas3Yps8r8r16d0VxGBqu8t3mKDR956ChqFzYd
        jWXQcjJRPqgrPQDCbIV0aZ02+7ePS6vhfNkUXHbRwIPuX5y6KQ31HyAjOfAR/Z4nmK0KgGNmeTBYP
        rhu4QIn2k2Mi3MWhmh1eFxR9BA+PG5OsDVm5OhNK/tj9UXc5/C8AJ+pmmh74qHlg9TCVdRont5U/3
        Wg3kyBwrWbBGNvqM2asifJOvTuLpwogBtJkpL5Lz0xO2CbGdEBUSTHSLtu4e6UCOz101xUfoV3G+K
        T1Vdy4Yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8J0m-003Ouz-6j; Tue, 27 Jul 2021 09:04:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D19AE30022A;
        Tue, 27 Jul 2021 11:04:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BADCE213986EE; Tue, 27 Jul 2021 11:04:27 +0200 (CEST)
Date:   Tue, 27 Jul 2021 11:04:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
Message-ID: <YP/MG3ZTq+fmJ+YQ@hirez.programming.kicks-ass.net>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726161211.925206-5-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 26, 2021 at 09:12:01AM -0700, Andrii Nakryiko wrote:
> Introduce a new type of BPF link - BPF perf link. This brings perf_event-based
> BPF program attachments (perf_event, tracepoints, kprobes, and uprobes) into
> the common BPF link infrastructure, allowing to list all active perf_event
> based attachments, auto-detaching BPF program from perf_event when link's FD
> is closed, get generic BPF link fdinfo/get_info functionality.
> 
> BPF_LINK_CREATE command expects perf_event's FD as target_fd. No extra flags
> are currently supported.
> 
> Force-detaching and atomic BPF program updates are not yet implemented, but
> with perf_event-based BPF links we now have common framework for this without
> the need to extend ioctl()-based perf_event interface.
> 
> One interesting consideration is a new value for bpf_attach_type, which
> BPF_LINK_CREATE command expects. Generally, it's either 1-to-1 mapping from
> bpf_attach_type to bpf_prog_type, or many-to-1 mapping from a subset of
> bpf_attach_types to one bpf_prog_type (e.g., see BPF_PROG_TYPE_SK_SKB or
> BPF_PROG_TYPE_CGROUP_SOCK). In this case, though, we have three different
> program types (KPROBE, TRACEPOINT, PERF_EVENT) using the same perf_event-based
> mechanism, so it's many bpf_prog_types to one bpf_attach_type. I chose to
> define a single BPF_PERF_EVENT attach type for all of them and adjust
> link_create()'s logic for checking correspondence between attach type and
> program type.
> 
> The alternative would be to define three new attach types (e.g., BPF_KPROBE,
> BPF_TRACEPOINT, and BPF_PERF_EVENT), but that seemed like unnecessary overkill
> and BPF_KPROBE will cause naming conflicts with BPF_KPROBE() macro, defined by
> libbpf. I chose to not do this to avoid unnecessary proliferation of
> bpf_attach_type enum values and not have to deal with naming conflicts.
> 

So I have no idea what all that means... I don't speak BPF. That said,
the patch doesn't look terrible.

One little question below, but otherwise:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> +static void bpf_perf_link_release(struct bpf_link *link)
> +{
> +	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> +	struct perf_event *event = perf_link->perf_file->private_data;
> +
> +	perf_event_free_bpf_prog(event);
> +	fput(perf_link->perf_file);
> +}

> +static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +	struct bpf_link_primer link_primer;
> +	struct bpf_perf_link *link;
> +	struct perf_event *event;
> +	struct file *perf_file;
> +	int err;
> +
> +	if (attr->link_create.flags)
> +		return -EINVAL;
> +
> +	perf_file = perf_event_get(attr->link_create.target_fd);
> +	if (IS_ERR(perf_file))
> +		return PTR_ERR(perf_file);
> +
> +	link = kzalloc(sizeof(*link), GFP_USER);
> +	if (!link) {
> +		err = -ENOMEM;
> +		goto out_put_file;
> +	}
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
> +	link->perf_file = perf_file;
> +
> +	err = bpf_link_prime(&link->link, &link_primer);
> +	if (err) {
> +		kfree(link);
> +		goto out_put_file;
> +	}
> +
> +	event = perf_file->private_data;
> +	err = perf_event_set_bpf_prog(event, prog);
> +	if (err) {
> +		bpf_link_cleanup(&link_primer);
> +		goto out_put_file;
> +	}
> +	/* perf_event_set_bpf_prog() doesn't take its own refcnt on prog */

Is that otherwise expected? AFAICT the previous users of that function
were guaranteed the existance of the BPF program. But afaict there is
nothing that prevents perf_event_*_bpf_prog() from doing the addition
refcounting if that is more convenient.

> +	bpf_prog_inc(prog);
> +
> +	return bpf_link_settle(&link_primer);
> +
> +out_put_file:
> +	fput(perf_file);
> +	return err;
> +}
