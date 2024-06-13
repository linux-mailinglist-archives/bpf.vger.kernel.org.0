Return-Path: <bpf+bounces-32041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65300906315
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 06:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B716CB22E48
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5BB13213E;
	Thu, 13 Jun 2024 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI0bqMZ8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E04084E;
	Thu, 13 Jun 2024 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252858; cv=none; b=W3wTJ/41nuc0vCee2ubMpe3qAVuN+xEiD+V/sQNjiYpvnADzObusNuAZPyXHGVEWr9QLaULl7NhveRswD50Vs256mBSxThBdaxob/UxAWRm6C2P2dSs93ejlQlKrs1fl7DaX3i7pMtzBGiH1jUvsTYqy8mbsuGG0Bch9UBz6RMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252858; c=relaxed/simple;
	bh=q+/ZoOoPYnClF9t7L4f+xIrrziAS2Md2xj1u2vxqRPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2QJ7jyyssYdaPp0FeYBX3jb8do3eaAAK+hjhWTW1RCtmouGvCUKK63RxX3yLKVT+rtQ6sQKcZtpPtrMTkQjn723E7G6rsjpgrarYwVj91+dPmNNraDpJgJGb6O6U0aXJaLhsrTToatPqIzSKHPReCary1SWbnhRbtPUjagFffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI0bqMZ8; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-627ebbefd85so6828597b3.3;
        Wed, 12 Jun 2024 21:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252855; x=1718857655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+9kO1Bf8WBlBJp5UGjZvzU+fEXiJb+0qO6s4CUuqhY=;
        b=aI0bqMZ8BU3qB4P6e0AjHZYw7R43AT/JEvrBllEWxctuIiTgfyLCPdkmowmKMxUVhi
         tQWb3rT+DrT6RvdCL18yeLRNiv9p5N4Z4AQ5dW5yYS8OsvtGI2dEBf8TCCtGJm2tEHso
         bIg4PNU+Zgg4GRm88RUebI+MUwIY/dGa8VSU4+DWoZxNyIjk7JSVGlYx+cxZM0ebl4kO
         hBSo4+vWEB3NFW86xwzyuGXRSMHZVi8/wWekj/5h/UTNi5Q90aLJDuUShR/w0mavpML/
         sv0otJzGxyOaqbF/oCcowlYC89TSRyhfzRxzHwr8fM89rCu8qtMzBpJu9DPABuZIiFHp
         Xesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252855; x=1718857655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+9kO1Bf8WBlBJp5UGjZvzU+fEXiJb+0qO6s4CUuqhY=;
        b=gCU/Saf3iPDgGp11e1AJwQbEMX07fa2xUtNsfxQmGr1l6rq1o77lv4TyYPJ1CAbg4H
         +tJLZXEDTzGpndbyZnwzMopN3CdrjG+SA7dqphW9WxjKYBxdn6gN/bAqjRjVVRe9IOrg
         UGIN3pc9183uWtlifX8zsus82rSebfuqPOylSmcf3w93tq/PyVOGSua+4equgiEYmJgk
         Qj4Cg16AuL6OqIubDuxchjWGRg2CzXiy26wTIiMPkbHlb4nH2db+XEY4XUUQpF+bLqG2
         +L7IQaExpgEEwXCOCUjj3e9sugcU3RxERlgPLgZAfIMLibWtO6ojSgZmEVNOmBYR5Qgd
         pm1A==
X-Forwarded-Encrypted: i=1; AJvYcCW5+j9/d2BMH5qx8CQWRujvOQ35vIONR6eTX34ilYjaG5PX8IYHkm2HfhYUvaruTabtQPPlZ7iQaHImTv8dSdanpQ+MQoqxzTV2FEufgs7q2SXe46g0S8aJM+DTbiMh0N7XIpcfwoFz+Sh3ohENjYDAZgm5b8b80nsa/FibaSi1GcDBMxGvb9+60quZhThe0lVJtdu39QTFHgLLyAFhBa2GcUM/sVI5HpJ2hg==
X-Gm-Message-State: AOJu0YxLWZhhRSZXaquybJkZ8ClBZGSYPiL+NIARzwY9TYV32AFGzSAF
	uYap4ojbK+aGRh1TyZvxO1MbWKwpxa1yWuL+/U8Hn/qiS/k1wqJP
X-Google-Smtp-Source: AGHT+IEGKZGby4tSb3umiNaFA6H7CDbHHfy1qVEq8enJBoBxgafNyPetFRWm1a9w7+caL8KuwPGfuQ==
X-Received: by 2002:a05:690c:6612:b0:61b:14a8:7944 with SMTP id 00721157ae682-62fc9ebfa84mr46393657b3.39.1718252854478;
        Wed, 12 Jun 2024 21:27:34 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f043f1sm3019005ad.204.2024.06.12.21.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:27:34 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	mic@digikod.net,
	gnoack@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4] perf trace: BTF-based enum pretty printing
Date: Thu, 13 Jun 2024 12:27:47 +0800
Message-ID: <20240613042747.3770204-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

changes in v4:

- Add enum support to tracepoint arguments

- For tracing syscalls, move trace__load_vmlinux_btf() to
syscall__set_arg_fmts() to make it more elegant

changes in v3:

- Fixed another awkward formatting issue in trace__load_vmlinux_btf()

changes in v2:

- Fix formatting issues

- Pass a &use_btf to syscall_arg_fmt__init_array(), instead of
traversing all the arguments again.

- Add a trace__load_vmlinux_btf() function to load vmlinux BTF

- Add member 'btf_entry' in 'struct syscall_arg_fmt' to save the entry to
the corresponding 'struct btf_member' object, without having to do
btf__find_by_name(), btf__type_by_id(), btf_enum(), and btf_vlen()
everytime a syscall enters.

=3D=3D=3D

v4 notes

before:

perf $ ./perf trace -e timer:hrtimer_start --max-events=3D1
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466c25f18, function: =
0xffffffff89da5be0, expires: 377432432256753, softexpires: 377432432256753,=
 mode: 10)

after:

perf $ ./perf trace -e timer:hrtimer_start --max-events=3D1
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466c25f18, function: =
0xffffffff89da5be0, expires: 377732805560049, softexpires: 377732805560049,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)

HRTIMER_MODE_ABS_PINNED_HARD is:

perf $ pahole hrtimer_mode
enum hrtimer_mode {
        HRTIMER_MODE_ABS             =3D 0,
        HRTIMER_MODE_REL             =3D 1,
        HRTIMER_MODE_PINNED          =3D 2,
        HRTIMER_MODE_SOFT            =3D 4,
        HRTIMER_MODE_HARD            =3D 8,
        HRTIMER_MODE_ABS_PINNED      =3D 2,
        HRTIMER_MODE_REL_PINNED      =3D 3,
        HRTIMER_MODE_ABS_SOFT        =3D 4,
        HRTIMER_MODE_REL_SOFT        =3D 5,
        HRTIMER_MODE_ABS_PINNED_SOFT =3D 6,
        HRTIMER_MODE_REL_PINNED_SOFT =3D 7,
        HRTIMER_MODE_ABS_HARD        =3D 8,
        HRTIMER_MODE_REL_HARD        =3D 9,
        HRTIMER_MODE_ABS_PINNED_HARD =3D 10,
        HRTIMER_MODE_REL_PINNED_HARD =3D 11,
};

this: HRTIMER_MODE_ABS_PINNED_HARD =3D 10,

Can also be tested by

./perf trace -e pagemap:mm_lru_insertion,timer:hrtimer_start,timer:hrtimer_=
init,skb:kfree_skb --max-events=3D10

(Chose these 4 tracepoints because they happen quite frequently.)

By using the command above, I got:

perf $ ./perf trace -e pagemap:mm_lru_insertion,timer:hrtimer_start,timer:h=
rtimer_init,skb:kfree_skb --max-events=3D10
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466c25f18, function: =
0xffffffff89da5be0, expires: 376189979047665, softexpires: 376189979047665,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.053 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466ca5f18, function: =
0xffffffff89da5be0, expires: 376230939043569, softexpires: 376230939043569,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.099 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466ca5f18, function: =
0xffffffff89da5be0, expires: 376111885722141, softexpires: 376111885722141,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.242 tmux: server/296019 timer:hrtimer_init(hrtimer: 0xffffb872caa1f6=
28, clockid: 1, mode: HRTIMER_MODE_ABS)
     0.244 tmux: server/296019 timer:hrtimer_start(hrtimer: 0xffffb872caa1f=
628, function: 0xffffffff89d90420, expires: 376111894496606, softexpires: 3=
76111894446606, mode: HRTIMER_MODE_ABS)
     0.349 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466ca5f18, function: =
0xffffffff89da5be0, expires: 376230939043569, softexpires: 376230939043569,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.486 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466ca5f18, function: =
0xffffffff89da5be0, expires: 376111885722141, softexpires: 376111885722141,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.499 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466ca5f18, function: =
0xffffffff89da5be0, expires: 376230939043569, softexpires: 376230939043569,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.501 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466ca5f18, function: =
0xffffffff89da5be0, expires: 376111885722141, softexpires: 376111885722141,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.506 :0/0 timer:hrtimer_start(hrtimer: 0xffff974466ca5f18, function: =
0xffffffff89da5be0, expires: 376230939043569, softexpires: 376230939043569,=
 mode: HRTIMER_MODE_ABS_PINNED_HARD)

If you want to test all tracepoints that has enum arguments, and
that enum argument is retrievable in vmlinux:

./perf trace -e power:dev_pm_qos_add_request,power:dev_pm_qos_remove_reques=
t,power:dev_pm_qos_update_request,error_report:error_report_end,error_repor=
t:error_report_end,timer:hrtimer_init,timer:hrtimer_start,i2c_slave:i2c_sla=
ve,cfg80211:cfg80211_get_bss,pagemap:mm_lru_insertion,migrate:mm_migrate_pa=
ges,migrate:mm_migrate_pages_start,cfg80211:rdev_auth,cfg80211:rdev_connect=
,cfg80211:rdev_start_ap,cfg80211:cfg80211_chandef_dfs_required,cfg80211:cfg=
80211_ch_switch_notify,cfg80211:cfg80211_ch_switch_started_notify,cfg80211:=
cfg80211_get_bss,cfg80211:cfg80211_ibss_joined,cfg80211:cfg80211_inform_bss=
_frame,cfg80211:cfg80211_radar_event,cfg80211:cfg80211_ready_on_channel_exp=
ired,cfg80211:cfg80211_ready_on_channel,cfg80211:cfg80211_reg_can_beacon,cf=
g80211:cfg80211_return_bss,cfg80211:cfg80211_tx_mgmt_expired,cfg80211:rdev_=
channel_switch,cfg80211:rdev_inform_bss,cfg80211:rdev_libertas_set_mesh_cha=
nnel,cfg80211:rdev_mgmt_tx,cfg80211:rdev_remain_on_channel,cfg80211:rdev_re=
turn_chandef,cfg80211:rdev_return_int_survey_info,cfg80211:rdev_set_ap_chan=
width,cfg80211:rdev_set_monitor_channel,cfg80211:rdev_set_radar_background,=
cfg80211:rdev_start_ap,cfg80211:rdev_start_radar_detection,cfg80211:rdev_td=
ls_channel_switch,cfg80211:cfg80211_reg_can_beacon,cfg80211:rdev_add_virtua=
l_intf,cfg80211:rdev_change_virtual_intf,sched:sched_skip_vma_numa,power:pm=
_qos_update_flags,power:pm_qos_update_target,pwm:pwm_apply,pwm:pwm_get,skb:=
kfree_skb,thermal:thermal_zone_trip,xen:xen_mc_batch,xen:xen_mc_issue,xen:x=
en_mc_extend_args,xen:xen_mc_extend_args,xen:xen_mc_flush_reason,xen:xen_mc=
_flush_reason,compaction:mm_compaction_defer_compaction,compaction:mm_compa=
ction_deferred,compaction:mm_compaction_defer_reset,compaction:mm_compactio=
n_finished,compaction:mm_compaction_kcompactd_wake,compaction:mm_compaction=
_suitable,compaction:mm_compaction_wakeup_kcompactd --max-events=3D20

But whether this enum is in vmlinux may vary on different versions.
If you want to find out which enum type is in vmlinux, please use:

vmlinux_dir $ bpftool btf dump file /sys/kernel/btf/vmlinux > vmlinux

vmlinux_dir $  while read l; do grep "ENUM '$l'" vmlinux; done < <(grep fie=
ld:enum /sys/kernel/tracing/events/*/*/format | awk '{print $3}' | sort | u=
niq) | awk '{print $3}' | sed "s/'\(.*\)'/\1/g"
dev_pm_qos_req_type
error_detector
hrtimer_mode
i2c_slave_event
ieee80211_bss_type
lru_list
migrate_mode
nl80211_auth_type
nl80211_band
nl80211_iftype
numa_vmaskip_reason
pm_qos_req_action
pwm_polarity
skb_drop_reason
thermal_trip_type
xen_lazy_mode
xen_mc_extend_args
xen_mc_flush_reason
zone_type

And what tracepoints have these enum types as their arguments:

vmlinux_dir $ while read l; do grep "ENUM '$l'" vmlinux; done < <(grep fiel=
d:enum /sys/kernel/tracing/events/*/*/format | awk '{print $3}' | sort | un=
iq) | awk '{print $3}' | sed "s/'\(.*\)'/\1/g" > good_enums

vmlinux_dir $ cat good_enums
dev_pm_qos_req_type
error_detector
hrtimer_mode
i2c_slave_event
ieee80211_bss_type
lru_list
migrate_mode
nl80211_auth_type
nl80211_band
nl80211_iftype
numa_vmaskip_reason
pm_qos_req_action
pwm_polarity
skb_drop_reason
thermal_trip_type
xen_lazy_mode
xen_mc_extend_args
xen_mc_flush_reason
zone_type

vmlinux_dir $ grep -f good_enums -l /sys/kernel/tracing/events/*/*/format
/sys/kernel/tracing/events/cfg80211/cfg80211_chandef_dfs_required/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_notify/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_started_notify/format
/sys/kernel/tracing/events/cfg80211/cfg80211_get_bss/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ibss_joined/format
/sys/kernel/tracing/events/cfg80211/cfg80211_inform_bss_frame/format
/sys/kernel/tracing/events/cfg80211/cfg80211_radar_event/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ready_on_channel_expired/format
/sys/kernel/tracing/events/cfg80211/cfg80211_ready_on_channel/format
/sys/kernel/tracing/events/cfg80211/cfg80211_reg_can_beacon/format
/sys/kernel/tracing/events/cfg80211/cfg80211_return_bss/format
/sys/kernel/tracing/events/cfg80211/cfg80211_tx_mgmt_expired/format
/sys/kernel/tracing/events/cfg80211/rdev_add_virtual_intf/format
/sys/kernel/tracing/events/cfg80211/rdev_auth/format
/sys/kernel/tracing/events/cfg80211/rdev_change_virtual_intf/format
/sys/kernel/tracing/events/cfg80211/rdev_channel_switch/format
/sys/kernel/tracing/events/cfg80211/rdev_connect/format
/sys/kernel/tracing/events/cfg80211/rdev_inform_bss/format
/sys/kernel/tracing/events/cfg80211/rdev_libertas_set_mesh_channel/format
/sys/kernel/tracing/events/cfg80211/rdev_mgmt_tx/format
/sys/kernel/tracing/events/cfg80211/rdev_remain_on_channel/format
/sys/kernel/tracing/events/cfg80211/rdev_return_chandef/format
/sys/kernel/tracing/events/cfg80211/rdev_return_int_survey_info/format
/sys/kernel/tracing/events/cfg80211/rdev_set_ap_chanwidth/format
/sys/kernel/tracing/events/cfg80211/rdev_set_monitor_channel/format
/sys/kernel/tracing/events/cfg80211/rdev_set_radar_background/format
/sys/kernel/tracing/events/cfg80211/rdev_start_ap/format
/sys/kernel/tracing/events/cfg80211/rdev_start_radar_detection/format
/sys/kernel/tracing/events/cfg80211/rdev_tdls_channel_switch/format
/sys/kernel/tracing/events/compaction/mm_compaction_defer_compaction/format
/sys/kernel/tracing/events/compaction/mm_compaction_deferred/format
/sys/kernel/tracing/events/compaction/mm_compaction_defer_reset/format
/sys/kernel/tracing/events/compaction/mm_compaction_finished/format
/sys/kernel/tracing/events/compaction/mm_compaction_kcompactd_wake/format
/sys/kernel/tracing/events/compaction/mm_compaction_suitable/format
/sys/kernel/tracing/events/compaction/mm_compaction_wakeup_kcompactd/format
/sys/kernel/tracing/events/error_report/error_report_end/format
/sys/kernel/tracing/events/i2c_slave/i2c_slave/format
/sys/kernel/tracing/events/migrate/mm_migrate_pages/format
/sys/kernel/tracing/events/migrate/mm_migrate_pages_start/format
/sys/kernel/tracing/events/pagemap/mm_lru_insertion/format
/sys/kernel/tracing/events/power/dev_pm_qos_add_request/format
/sys/kernel/tracing/events/power/dev_pm_qos_remove_request/format
/sys/kernel/tracing/events/power/dev_pm_qos_update_request/format
/sys/kernel/tracing/events/power/pm_qos_update_flags/format
/sys/kernel/tracing/events/power/pm_qos_update_target/format
/sys/kernel/tracing/events/pwm/pwm_apply/format
/sys/kernel/tracing/events/pwm/pwm_get/format
/sys/kernel/tracing/events/sched/sched_skip_vma_numa/format
/sys/kernel/tracing/events/skb/kfree_skb/format
/sys/kernel/tracing/events/thermal/thermal_zone_trip/format
/sys/kernel/tracing/events/timer/hrtimer_init/format
/sys/kernel/tracing/events/timer/hrtimer_start/format
/sys/kernel/tracing/events/xen/xen_mc_batch/format
/sys/kernel/tracing/events/xen/xen_mc_extend_args/format
/sys/kernel/tracing/events/xen/xen_mc_flush_reason/format
/sys/kernel/tracing/events/xen/xen_mc_issue/format

This is how I got the crazy long list of tracepoints above.

From there, please use the command below to get the events, and use it as .=
/perf trace -e's
argument

vmlinux_dir $ grep -f good_enums -l /sys/kernel/tracing/events/*/*/format |=
 sed "s/.*events\/\(.*\)\/\(.*\)\/.*/\1:\2/g"
cfg80211:cfg80211_chandef_dfs_required
cfg80211:cfg80211_ch_switch_notify
cfg80211:cfg80211_ch_switch_started_notify
cfg80211:cfg80211_get_bss
cfg80211:cfg80211_ibss_joined
cfg80211:cfg80211_inform_bss_frame
cfg80211:cfg80211_radar_event
cfg80211:cfg80211_ready_on_channel_expired
cfg80211:cfg80211_ready_on_channel
cfg80211:cfg80211_reg_can_beacon
cfg80211:cfg80211_return_bss
cfg80211:cfg80211_tx_mgmt_expired
cfg80211:rdev_add_virtual_intf
cfg80211:rdev_auth
cfg80211:rdev_change_virtual_intf
cfg80211:rdev_channel_switch
cfg80211:rdev_connect
cfg80211:rdev_inform_bss
cfg80211:rdev_libertas_set_mesh_channel
cfg80211:rdev_mgmt_tx
cfg80211:rdev_remain_on_channel
cfg80211:rdev_return_chandef
cfg80211:rdev_return_int_survey_info
cfg80211:rdev_set_ap_chanwidth
cfg80211:rdev_set_monitor_channel
cfg80211:rdev_set_radar_background
cfg80211:rdev_start_ap
cfg80211:rdev_start_radar_detection
cfg80211:rdev_tdls_channel_switch
compaction:mm_compaction_defer_compaction
compaction:mm_compaction_deferred
compaction:mm_compaction_defer_reset
compaction:mm_compaction_finished
compaction:mm_compaction_kcompactd_wake
compaction:mm_compaction_suitable
compaction:mm_compaction_wakeup_kcompactd
error_report:error_report_end
i2c_slave:i2c_slave
migrate:mm_migrate_pages
migrate:mm_migrate_pages_start
pagemap:mm_lru_insertion
power:dev_pm_qos_add_request
power:dev_pm_qos_remove_request
power:dev_pm_qos_update_request
power:pm_qos_update_flags
power:pm_qos_update_target
pwm:pwm_apply
pwm:pwm_get
sched:sched_skip_vma_numa
skb:kfree_skb
thermal:thermal_zone_trip
timer:hrtimer_init
timer:hrtimer_start
xen:xen_mc_batch
xen:xen_mc_extend_args
xen:xen_mc_flush_reason
xen:xen_mc_issue

=3D=3D=3D

v2 notes

In 'struct syscall_arg_fmt':
```
	struct {
		void	*entry;
		u16	nr_entries;
	}	   btf_entry;
```

This is the new member btf_entry. 'struct btf_member' object, so that
we don't have to do btf__find_by_name(), btf__type_by_id(), btf_enum(),
and btf_vlen() everytime a landlock_add_rule() syscall entered.

Note that entry is of type 'void *', because this btf_entry can also be
applied to 'struct btf_member *' for 'BTF_KIND_STRUCT', hopefully in the
future.

=3D=3D=3D

v1 notes

This is a feature implemented on the basis of the previous bug fix
https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb=
90@web.de/T/#t

In this patch, BTF is used to turn enum value to the corresponding
name. There is only one system call that uses enum value as its
argument, that is `landlock_add_rule()`.

The vmlinux btf is loaded lazily, when user decided to trace the
`landlock_add_rule` syscall. But if one decide to run `perf trace`
without any arguments, the behaviour is to trace `landlock_add_rule`,
so vmlinux btf will be loaded by default.

The laziest behaviour is to load vmlinux btf when a
`landlock_add_rule` syscall hits. But I think you could lose some
samples when loading vmlinux btf at run time, for it can delay the
handling of other samples. I might need your precious opinions on
this...

before:

```
perf $ ./perf trace -e landlock_add_rule
     0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)  =
                                     =3D -1 EBADFD (File descriptor in bad =
state)
     0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)  =
                                     =3D -1 EBADFD (File descriptor in bad =
state)
```

after:

```
perf $ ./perf trace -e landlock_add_rule
     0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LAND=
LOCK_RULE_NET_PORT)                  =3D -1 EBADFD (File descriptor in bad =
state)
     0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LAND=
LOCK_RULE_PATH_BENEATH)              =3D -1 EBADFD (File descriptor in bad =
state)
```

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 121 ++++++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5cbe1748911d..0a168cb9b0c2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <bpf/btf.h>
 #ifdef HAVE_BPF_SKEL
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
 #endif
@@ -110,6 +111,11 @@ struct syscall_arg_fmt {
 	const char *name;
 	u16	   nr_entries; // for arrays
 	bool	   show_zero;
+	bool	   is_enum;
+	struct {
+		void	*entry;
+		u16	nr_entries;
+	}	   btf_entry;
 };
=20
 struct syscall_fmt {
@@ -140,6 +146,7 @@ struct trace {
 #ifdef HAVE_BPF_SKEL
 	struct augmented_raw_syscalls_bpf *skel;
 #endif
+	struct btf		*btf;
 	struct record_opts	opts;
 	struct evlist	*evlist;
 	struct machine		*host;
@@ -887,6 +894,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(c=
har *bf, size_t size,
=20
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
=20
+static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall=
_arg_fmt *arg_fmt)
+{
+	const struct btf_type *bt;
+	char enum_prefix[][16] =3D { "enum", "const enum" }, *ep;
+	int id;
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(enum_prefix); i++) {
+		ep =3D enum_prefix[i];
+		if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
+			type +=3D strlen(ep) + 1;
+	}
+
+	id =3D btf__find_by_name(btf, type);
+	if (id < 0)
+		return -1;
+
+	bt =3D btf__type_by_id(btf, id);
+	if (bt =3D=3D NULL)
+		return -1;
+
+	arg_fmt->btf_entry.entry      =3D btf_enum(bt);
+	arg_fmt->btf_entry.nr_entries =3D btf_vlen(bt);
+
+	return 0;
+}
+
+static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct bt=
f *btf, char *type,
+				 struct syscall_arg_fmt *arg_fmt)
+{
+	struct btf_enum *be;
+	int i;
+
+	/* if btf_entry is NULL, find and save it to arg_fmt */
+	if (arg_fmt->btf_entry.entry =3D=3D NULL)
+		if (btf_enum_find_entry(btf, type, arg_fmt))
+			return 0;
+
+	be =3D (struct btf_enum *)arg_fmt->btf_entry.entry;
+
+	for (i =3D 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
+		if (be->val =3D=3D val) {
+			return scnprintf(bf, size, "%s",
+					 btf__name_by_offset(btf, be->name_off));
+		}
+	}
+
+	return 0;
+}
+
 #define STRARRAY(name, array) \
 	  { .scnprintf	=3D SCA_STRARRAY, \
 	    .strtoul	=3D STUL_STRARRAY, \
@@ -1238,6 +1295,7 @@ struct syscall {
 	bool		    is_exit;
 	bool		    is_open;
 	bool		    nonexistent;
+	bool		    use_btf;
 	struct tep_format_field *args;
 	const char	    *name;
 	const struct syscall_fmt  *fmt;
@@ -1699,6 +1757,15 @@ static void trace__symbols__exit(struct trace *trace)
 	symbol__exit();
 }
=20
+static void trace__load_vmlinux_btf(struct trace *trace)
+{
+	trace->btf =3D btf__load_vmlinux_btf();
+	if (verbose > 0) {
+		fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
+						    "Failed to load vmlinux BTF\n");
+	}
+}
+
 static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
@@ -1744,7 +1811,8 @@ static const struct syscall_arg_fmt *syscall_arg_fmt_=
_find_by_name(const char *n
 }
=20
 static struct tep_format_field *
-syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format=
_field *field)
+syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format=
_field *field,
+			    bool *use_btf)
 {
 	struct tep_format_field *last_field =3D NULL;
 	int len;
@@ -1756,6 +1824,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *a=
rg, struct tep_format_field
 			continue;
=20
 		len =3D strlen(field->name);
+		arg->is_enum =3D false;
=20
 		if (strcmp(field->type, "const char *") =3D=3D 0 &&
 		    ((len >=3D 4 && strcmp(field->name + len - 4, "name") =3D=3D 0) ||
@@ -1782,6 +1851,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *a=
rg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf =3D SCA_FD;
+		} else if (strstr(field->type, "enum") && use_btf !=3D NULL) {
+			*use_btf =3D arg->is_enum =3D true;
 		} else {
 			const struct syscall_arg_fmt *fmt =3D
 				syscall_arg_fmt__find_by_name(field->name);
@@ -1796,9 +1867,14 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *=
arg, struct tep_format_field
 	return last_field;
 }
=20
-static int syscall__set_arg_fmts(struct syscall *sc)
+static int syscall__set_arg_fmts(struct trace *trace, struct syscall *sc)
 {
-	struct tep_format_field *last_field =3D syscall_arg_fmt__init_array(sc->a=
rg_fmt, sc->args);
+	bool use_btf;
+	struct tep_format_field *last_field =3D syscall_arg_fmt__init_array(sc->a=
rg_fmt, sc->args,
+									  &use_btf);
+
+	if (use_btf && trace->btf =3D=3D NULL)
+		trace__load_vmlinux_btf(trace);
=20
 	if (last_field)
 		sc->args_size =3D last_field->offset + last_field->size;
@@ -1883,15 +1959,20 @@ static int trace__read_syscall_info(struct trace *t=
race, int id)
 	sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "openat");
=20
-	return syscall__set_arg_fmts(sc);
+	return syscall__set_arg_fmts(trace, sc);
 }
=20
-static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
+static int evsel__init_tp_arg_scnprintf(struct trace *trace, struct evsel =
*evsel)
 {
 	struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(evsel);
+	bool use_btf;
=20
 	if (fmt !=3D NULL) {
-		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, &use_b=
tf);
+
+		if (use_btf && trace->btf =3D=3D NULL)
+			trace__load_vmlinux_btf(trace);
+
 		return 0;
 	}
=20
@@ -2103,6 +2184,16 @@ static size_t syscall__scnprintf_args(struct syscall=
 *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed +=3D scnprintf(bf + printed, size - printed, "%s: ", field->na=
me);
=20
+			if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
+				size_t p =3D btf_enum_scnprintf(bf + printed, size - printed, val,
+							      trace->btf, field->type,
+							      &sc->arg_fmt[arg.idx]);
+				if (p) {
+					printed +=3D p;
+					continue;
+				}
+			}
+
 			printed +=3D syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
 								  bf + printed, size - printed, &arg, val);
 		}
@@ -2791,7 +2882,7 @@ static size_t trace__fprintf_tp_fields(struct trace *=
trace, struct evsel *evsel,
 		val =3D syscall_arg_fmt__mask_val(arg, &syscall_arg, val);
=20
 		/* Suppress this argument if its value is zero and show_zero property is=
n't set. */
-		if (val =3D=3D 0 && !trace->show_zeros && !arg->show_zero)
+		if (val =3D=3D 0 && !trace->show_zeros && !arg->show_zero && !arg->is_en=
um)
 			continue;
=20
 		printed +=3D scnprintf(bf + printed, size - printed, "%s", printed ? ", =
" : "");
@@ -2799,6 +2890,15 @@ static size_t trace__fprintf_tp_fields(struct trace =
*trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed +=3D scnprintf(bf + printed, size - printed, "%s: ", field->nam=
e);
=20
+		if (arg->is_enum && trace->btf) {
+			size_t p =3D btf_enum_scnprintf(bf + printed, size - printed, val, trac=
e->btf,
+						      field->type, arg);
+			if (p) {
+				printed +=3D p;
+				continue;
+			}
+		}
+
 		printed +=3D syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - pr=
inted, &syscall_arg, val);
 	}
=20
@@ -4461,8 +4561,9 @@ static void evsel__set_syscall_arg_fmt(struct evsel *=
evsel, const char *name)
 	}
 }
=20
-static int evlist__set_syscall_tp_fields(struct evlist *evlist)
+static int evlist__set_syscall_tp_fields(struct trace *trace)
 {
+	struct evlist *evlist =3D trace->evlist;
 	struct evsel *evsel;
=20
 	evlist__for_each_entry(evlist, evsel) {
@@ -4470,7 +4571,7 @@ static int evlist__set_syscall_tp_fields(struct evlis=
t *evlist)
 			continue;
=20
 		if (strcmp(evsel->tp_format->system, "syscalls")) {
-			evsel__init_tp_arg_scnprintf(evsel);
+			evsel__init_tp_arg_scnprintf(trace, evsel);
 			continue;
 		}
=20
@@ -4949,7 +5050,7 @@ int cmd_trace(int argc, const char **argv)
=20
 	if (trace.evlist->core.nr_entries > 0) {
 		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
-		if (evlist__set_syscall_tp_fields(trace.evlist)) {
+		if (evlist__set_syscall_tp_fields(&trace)) {
 			perror("failed to set syscalls:* tracepoint fields");
 			goto out;
 		}
--=20
2.45.2


