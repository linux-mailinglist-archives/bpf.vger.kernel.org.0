Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F821798E4
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 20:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgCDTV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 14:21:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbgCDTV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 14:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583349715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PN1s2TsuVWBsmIwRsKS2L9myyWVgvomrEpgA01wuzQ=;
        b=KhlUSj7KVV+a52QcESR+NbtxwoXLweayPKUNspxb7fOGS1aIKHkCcbQ0EkEGjKksL9sUTs
        fxZsdV2Yh+EpDONZpaG0tfEvzebFZnkB0KKyIXI9wcEhnUvg/+w4pnAMYh1NKfaCzthgOT
        8cB2aEorhVaDv1u/f7o7HJEUUzLjuQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ETRf-LaQMy22UY9oNdh72Q-1; Wed, 04 Mar 2020 14:21:52 -0500
X-MC-Unique: ETRf-LaQMy22UY9oNdh72Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3DC107ACC7;
        Wed,  4 Mar 2020 19:21:50 +0000 (UTC)
Received: from krava (ovpn-205-10.brq.redhat.com [10.40.205.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DA4D60BF3;
        Wed,  4 Mar 2020 19:21:48 +0000 (UTC)
Date:   Wed, 4 Mar 2020 20:21:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, quentin@isovalent.com,
        kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
        arnaldo.melo@gmail.com, jolsa@kernel.org
Subject: Re: [PATCH v4 bpf-next 1/4] bpftool: introduce "prog profile" command
Message-ID: <20200304192111.GB168640@krava>
References: <20200304180710.2677695-1-songliubraving@fb.com>
 <20200304180710.2677695-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304180710.2677695-2-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 04, 2020 at 10:07:07AM -0800, Song Liu wrote:
> With fentry/fexit programs, it is possible to profile BPF program with
> hardware counters. Introduce bpftool "prog profile", which measures key
> metrics of a BPF program.
> 
> bpftool prog profile command creates per-cpu perf events. Then it attaches
> fentry/fexit programs to the target BPF program. The fentry program saves
> perf event value to a map. The fexit program reads the perf event again,
> and calculates the difference, which is the instructions/cycles used by
> the target program.
> 
> Example input and output:
> 
>   ./bpftool prog profile id 337 duration 3 cycles instructions llc_misses
> 
>         4228 run_cnt
>      3403698 cycles                                              (84.08%)
>      3525294 instructions   #  1.04 insn per cycle               (84.05%)
>           13 llc_misses     #  3.69 LLC misses per million isns  (83.50%)

FYI I'm in the middle of moving perf's 'events parsing' interface to libperf,
which takes event name/s on input and returns list of perf_event_attr objects

  parse_events("cycles") -> ready to use 'struct perf_event_attr'

You can use any event that's listed in 'perf list' command, which includes
also all vendor (Intel/Arm/ppc..) events. It might be useful extension for
this command.

jirka

