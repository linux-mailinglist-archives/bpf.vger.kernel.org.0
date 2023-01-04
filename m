Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8D65D4B4
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 14:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjADNwU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 08:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbjADNwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 08:52:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3195C7657;
        Wed,  4 Jan 2023 05:52:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A15AF6173D;
        Wed,  4 Jan 2023 13:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B5BC433EF;
        Wed,  4 Jan 2023 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672840320;
        bh=zESvBys6+ijsskoiD+WZAQfcK9HlkvwqKa5QFLGE1+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RzK+HN/GgtdsCdbn2JfClMtYHrLB+Q54mgXbsqtwIx8SyQZ4JRS0hQviCOPvmn6zt
         V8xGTINAh6SdwWQjlTaCRYWHUla2RCeaccZc3Zr1SFpOlZcWMnS22eh+AsYKaQVS8L
         5T6pWaWNFAowfSNGGgGugaOaCxD49U+kjM4dIaNFCdH1V1boAFVvfXOataMRp87M0c
         aRKAfm4QVy7eDdJQzSQvjdUHFBsADtopCPJ5x4Hq4GQg9pracJljqowtVUD2snqqBb
         s1UJEU3pyaVLLLnd/P2zLZHBK4AKx1FDQ2BAMD/9E69Jepr5x5PzUQM5WopNpIDmMV
         L7W5X66GPo1fw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0160740468; Wed,  4 Jan 2023 10:51:56 -0300 (-03)
Date:   Wed, 4 Jan 2023 10:51:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: Re: [PATCH 3/4] perf bpf_counter: Handle unsupported cgroup events
Message-ID: <Y7WEfDHc5xw6x3t8@kernel.org>
References: <20230104064402.1551516-1-namhyung@kernel.org>
 <20230104064402.1551516-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104064402.1551516-4-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jan 03, 2023 at 10:44:01PM -0800, Namhyung Kim escreveu:
> When --for-each-cgroup option is used, it failed when any of events is not
> supported and it exited immediately.  This is not how perf stat handles the
> unsupported events.  Let's ignore the failure and proceed with others.
> 
> Before:
>   $ sudo ./perf stat -a --bpf-counters -e L1-icache-loads,L1-dcache-loads \
>   > --for-each-cgroup system.slice,user.slice  sleep 1
>   Failed to open first cgroup events

Interesting, tried the above on a arm64 machine and it all works:

root@roc-rk3399-pc:~# strace -e bpf,perf_event_open perf stat -a --bpf-counters -e L1-icache-loads,L1-dcache-loads --for-each-cgroup system.slice,user.slice sleep 1
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0xffffd36afc98, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 116) = 5
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0xffffd36afee8, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 128) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\20\0\0\0\20\0\0\0\5\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=45, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\08\0\0\08\0\0\0\t\0\0\0\0\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=89, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\f\0\0\0\f\0\0\0\7\0\0\0\1\0\0\0\0\0\0\20"..., btf_log_buf=NULL, btf_size=43, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\5\0\0\0\0\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=77, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0(\0\0\0(\0\0\0\5\0\0\0\0\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=69, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\f\0\0\0\f\0\0\0\10\0\0\0\1\0\0\0\0\0\0\23"..., btf_log_buf=NULL, btf_size=44, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0@G\0\0@G\0\0\2725\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=32018, btf_log_size=0, btf_log_level=0}, 28) = 5
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0xffffd36afb18, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="libbpf_nametest"}, 64) = 6
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="libbpf_mmap", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 6
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=12, map_flags=0, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 6
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=8, value_size=4, max_entries=2, map_flags=0, inner_map_fd=0, map_name="cgrp_idx", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 7
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=2, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 9
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=4, map_flags=0, inner_map_fd=0, map_name="cgrp_readings", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 10
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=32, max_entries=1, map_flags=0, inner_map_fd=0, map_name="libbpf_global", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 11
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=5, insns=0xffffd36afb80, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 128) = 12
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_RDONLY_PROG|BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_cg.rodata", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=413, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 11
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=11, key=0xffffd36afcdc, value=0xffff8da49000, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_FREEZE, {map_fd=11}, 4)     = 0
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_cg.bss", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=410, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 12
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=12, key=0xffffd36afcdc, value=0xffff8da48000, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_cg.data", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=411, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 13
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=13, key=0xffffd36afcdc, value=0xffff8da47000, flags=BPF_ANY}, 32) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=6, insns=0xffffd36afd48, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 128) = 14
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_PERF_EVENT, insn_cnt=306, insns=0xaaaaf14b9de0, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(6, 1, 0), prog_flags=0, prog_name="on_cgrp_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=5, func_info_rec_size=8, func_info=0xaaaaf14baec0, func_info_cnt=2, line_info_rec_size=16, line_info=0xaaaaf1491390, line_info_cnt=109, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 128) = 14
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=32, max_entries=1, map_flags=0, inner_map_fd=0, map_name="libbpf_det_bind", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0}, 72) = 15
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0xffffd36af358, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 128) = 16
bpf(BPF_PROG_BIND_MAP, 0xffffd36af288, 12) = 0
bpf(BPF_PROG_BIND_MAP, 0xffffd36af398, 12) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=306, insns=0xaaaaf1491a70, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(6, 1, 0), prog_flags=0, prog_name="trigger_read", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=5, func_info_rec_size=8, func_info=0xaaaaf14b9ad0, func_info_cnt=2, line_info_rec_size=16, line_info=0xaaaaf1492710, line_info_cnt=109, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 128) = 15
bpf(BPF_PROG_BIND_MAP, 0xffffd36af398, 12) = 0
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_SW_CGROUP_SWITCHES, sample_period=1, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, -1, 0, -1, PERF_FLAG_FD_CLOEXEC) = 16
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_SW_CGROUP_SWITCHES, sample_period=1, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, -1, 1, -1, PERF_FLAG_FD_CLOEXEC) = 17
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_SW_CGROUP_SWITCHES, sample_period=1, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, -1, 2, -1, PERF_FLAG_FD_CLOEXEC) = 18
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_SW_CGROUP_SWITCHES, sample_period=1, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, -1, 3, -1, PERF_FLAG_FD_CLOEXEC) = 19
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_SW_CGROUP_SWITCHES, sample_period=1, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, -1, 4, -1, PERF_FLAG_FD_CLOEXEC) = 20
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_SW_CGROUP_SWITCHES, sample_period=1, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, -1, 5, -1, PERF_FLAG_FD_CLOEXEC) = 21
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=2, insns=0xffffd36afe28, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL}, 128) = 22
bpf(BPF_LINK_CREATE, {link_create={prog_fd=22, target_fd=-1, attach_type=BPF_PERF_EVENT, flags=0}}, 48) = -1 EBADF (Bad file descriptor)
bpf(BPF_LINK_CREATE, {link_create={prog_fd=14, target_fd=16, attach_type=BPF_PERF_EVENT, flags=0}}, 48) = 22
bpf(BPF_LINK_CREATE, {link_create={prog_fd=14, target_fd=17, attach_type=BPF_PERF_EVENT, flags=0}}, 48) = 23
bpf(BPF_LINK_CREATE, {link_create={prog_fd=14, target_fd=18, attach_type=BPF_PERF_EVENT, flags=0}}, 48) = 24
bpf(BPF_LINK_CREATE, {link_create={prog_fd=14, target_fd=19, attach_type=BPF_PERF_EVENT, flags=0}}, 48) = 25
bpf(BPF_LINK_CREATE, {link_create={prog_fd=14, target_fd=20, attach_type=BPF_PERF_EVENT, flags=0}}, 48) = 26
bpf(BPF_LINK_CREATE, {link_create={prog_fd=14, target_fd=21, attach_type=BPF_PERF_EVENT, flags=0}}, 48) = 27
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1I, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 0, -1, PERF_FLAG_FD_CLOEXEC) = 28
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1I, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 1, -1, PERF_FLAG_FD_CLOEXEC) = 29
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1I, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 2, -1, PERF_FLAG_FD_CLOEXEC) = 30
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1I, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 3, -1, PERF_FLAG_FD_CLOEXEC) = 31
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1I, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 4, -1, PERF_FLAG_FD_CLOEXEC) = 32
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1I, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 5, -1, PERF_FLAG_FD_CLOEXEC) = 33
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0xaaaaf14c1c58, value=0xffffd36b005c, flags=BPF_ANY}, 32) = 0
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1D, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 0, -1, PERF_FLAG_FD_CLOEXEC) = 34
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1D, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 1, -1, PERF_FLAG_FD_CLOEXEC) = 35
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1D, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 2, -1, PERF_FLAG_FD_CLOEXEC) = 36
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1D, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 3, -1, PERF_FLAG_FD_CLOEXEC) = 37
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1D, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 4, -1, PERF_FLAG_FD_CLOEXEC) = 38
perf_event_open({type=PERF_TYPE_HW_CACHE, size=PERF_ATTR_SIZE_VER7, config=PERF_COUNT_HW_CACHE_RESULT_ACCESS<<16|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_L1D, sample_period=0, sample_type=0, read_format=0, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, -1, 5, -1, PERF_FLAG_FD_CLOEXEC) = 39
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=6, key=0xffffd36b00b0, value=0xffffd36b0060, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=7, key=0xaaaaf14c2278, value=0xffffd36b005c, flags=BPF_ANY}, 32) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=0}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=0}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=1}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=2}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=3}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=4}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=5}}, 80) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=8741, si_uid=0, si_status=0, si_utime=0, si_stime=1} ---
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=0}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=1}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=2}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=3}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=4}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=5}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=0}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=1}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=2}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=3}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=4}}, 80) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=15, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL, flags=BPF_F_TEST_RUN_ON_CPU, cpu=5}}, 80) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=10, key=0xffffd36b0004, value=0xaaaaf14be350, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=10, key=0xffffd36b0004, value=0xaaaaf14be350, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=10, key=0xffffd36b0004, value=0xaaaaf14be350, flags=BPF_ANY}, 32) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=10, key=0xffffd36b0004, value=0xaaaaf14be350, flags=BPF_ANY}, 32) = 0

 Performance counter stats for 'system wide':

             46116      L1-icache-loads                  system.slice
             15864      L1-dcache-loads                  system.slice
           8685400      L1-icache-loads                  user.slice
           3686787      L1-dcache-loads                  user.slice

       1.021264798 seconds time elapsed

--- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=8740, si_uid=0} ---
+++ exited with 0 +++
root@roc-rk3399-pc:~#
root@roc-rk3399-pc:~# perf -vv
perf version 6.2.rc2.gfb710ddee75f
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ OFF ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
root@roc-rk3399-pc:~#
root@roc-rk3399-pc:~# head -8 /proc/cpuinfo
processor	: 0
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4
root@roc-rk3399-pc:~# uname -a
Linux roc-rk3399-pc 6.1.0-rc5-00123-g4dd7ff4a0311 #2 SMP PREEMPT Wed Nov 16 19:55:11 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux
root@roc-rk3399-pc:~#

So these events are supported there, lets see with something else..

Before:

root@roc-rk3399-pc:~# perf stat -a --bpf-counters -e LLC-loads,LLC-stores --for-each-cgroup system.slice,user.slice sleep 1
Failed to open first cgroup events
root@roc-rk3399-pc:~#

After:

root@roc-rk3399-pc:~# perf stat -a --bpf-counters -e LLC-loads,LLC-stores --for-each-cgroup system.slice,user.slice sleep 1

 Performance counter stats for 'system wide':

   <not supported>      LLC-loads                        system.slice                                          
   <not supported>      LLC-stores                       system.slice                                          
   <not supported>      LLC-loads                        user.slice                                            
   <not supported>      LLC-stores                       user.slice                                            

       1.016196455 seconds time elapsed

root@roc-rk3399-pc:~# 

And with mixed supported/unsupported:

root@roc-rk3399-pc:~# perf stat -a --bpf-counters -e LLC-loads,LLC-stores,L1-icache-loads,L1-dcache-loads --for-each-cgroup system.slice,user.slice sleep 1

 Performance counter stats for 'system wide':

   <not supported>      LLC-loads                        system.slice                                          
   <not supported>      LLC-stores                       system.slice                                          
            180903      L1-icache-loads                  system.slice                                          
             66861      L1-dcache-loads                  system.slice                                          
   <not supported>      LLC-loads                        user.slice                                            
   <not supported>      LLC-stores                       user.slice                                            
           2948290      L1-icache-loads                  user.slice                                            
           1962675      L1-dcache-loads                  user.slice                                            

       1.016265003 seconds time elapsed

root@roc-rk3399-pc:~#

Applied,

- Arnaldo
 
> After:
>   $ sudo ./perf stat -a --bpf-counters -e L1-icache-loads,L1-dcache-loads \
>   > --for-each-cgroup system.slice,user.slice  sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>      <not supported>      L1-icache-loads                  system.slice
>           29,892,418      L1-dcache-loads                  system.slice
>      <not supported>      L1-icache-loads                  user.slice
>           52,497,220      L1-dcache-loads                  user.slice
> 
> Fixes: 944138f048f7d ("perf stat: Enable BPF counter with --for-each-cgroup")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_counter_cgroup.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index 3c2df7522f6f..1c82377ed78b 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -116,27 +116,19 @@ static int bperf_load_program(struct evlist *evlist)
>  
>  			/* open single copy of the events w/o cgroup */
>  			err = evsel__open_per_cpu(evsel, evsel->core.cpus, -1);
> -			if (err) {
> -				pr_err("Failed to open first cgroup events\n");
> -				goto out;
> -			}
> +			if (err == 0)
> +				evsel->supported = true;
>  
>  			map_fd = bpf_map__fd(skel->maps.events);
>  			perf_cpu_map__for_each_cpu(cpu, j, evsel->core.cpus) {
>  				int fd = FD(evsel, j);
>  				__u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
>  
> -				err = bpf_map_update_elem(map_fd, &idx, &fd,
> -							  BPF_ANY);
> -				if (err < 0) {
> -					pr_err("Failed to update perf_event fd\n");
> -					goto out;
> -				}
> +				bpf_map_update_elem(map_fd, &idx, &fd, BPF_ANY);
>  			}
>  
>  			evsel->cgrp = leader_cgrp;
>  		}
> -		evsel->supported = true;
>  
>  		if (evsel->cgrp == cgrp)
>  			continue;
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 

- Arnaldo
