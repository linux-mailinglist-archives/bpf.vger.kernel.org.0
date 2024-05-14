Return-Path: <bpf+bounces-29695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27698C5609
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEAA1F220B6
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02064F602;
	Tue, 14 May 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgv/wFb3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3803F9D9
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689765; cv=none; b=DDeYoHneI88wtRdP694XpU5zoPRv327iP7j14SvDC4j8bBWUigGJlqN5V2xSpc51ymrzBBrMj7dgvbGfwVC7B4JNzuffMx/m6pSKKenHpRxsREatsxkjF+psHUGjnC/G3nIKZoEB67l1g0ASyxrj6IdX6ol2Fch5cJSr+vmRIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689765; c=relaxed/simple;
	bh=zsffE+NtDx86dxu9w0jm+3xSTiYd2mgUjpE0JSBoaus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SiMBzZfjKRRKGXgw6kLcwWCnVxomd42ig/2rsG9V0CHmSkye/rMgK7XVHegKtltB7cp+82SXi0c1x0rpt2cuGr6mfDyzM5ZL1982deAk3hVLU1PBejxiKktjK0yDKCNoDvdq84Op+YRIZOqJpEQrCCYOGN7OS0XyQex5nqPsJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wgv/wFb3; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47f298cedcfso1836510137.1
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689762; x=1716294562; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMeMC7MwWEZw/ZVvhwM6C5GP6ZPwP1Atp+dqkO879VA=;
        b=Wgv/wFb3gTpZ+qt+e/CeJMgEK5udNzd19messPYbxJWK8Yj46vXW0lHZR44llX7jKo
         bKEi5ljF18+6ThPS8t94ewol35cKPP5/QRhKJ2Tee16tIL9Fbu+pBpbsUwAboPjP705c
         H3UHt6u8T7cC0NAOZitCjVyAirBm76C7F4+ASqjkJW0JQraEhsLIgvxfoJTPAH8PtGfl
         P7EV/l6p58V7i2Qn1qUa+nZD3D85PJ58b3dVLjHIDg0QDBHhiHm+BI4Aj4lUABStgs35
         9h9IMY5W0vSoU/W+dWz9tWE4CaxF282jVwmZI6AYAVf8shstlbxKjmvxJcuAmI+lFLO/
         w9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689762; x=1716294562;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMeMC7MwWEZw/ZVvhwM6C5GP6ZPwP1Atp+dqkO879VA=;
        b=A+LpKDpDI3wAPecvx0Aoil7yaGY8u+xdyuBstEzCYZrna/44YUM1GXVir5vUJyuQQF
         p2MdT5qvmDLjaWM4XsFK1Z3j36v5X3Jzmn06kqIcObpAwzApJqMBEBWI/OMJRXBbTkXU
         O5kG1whnSitMI0mvKT61M9/46PXsO7Ct2fftvAwBA5jC+ZO4BLfpxThLeMcbSJ9UqR5M
         Kl26TLHV1HGcDzgQ3vKgDTBU59+4QxyigAkqIQ+lRnbFiOWsAD24sG9+Pw45X17ClOav
         Emqo3xc9zyuzvmcSa2i2nqC8msKBWoRNWVT8ABalcivfImiOHCPt5qd0iM45SlzRCABs
         4U1w==
X-Gm-Message-State: AOJu0YzyMIF+I40y+Edan4Bikac/GXqfa5R3gelGYZBfm+6O4FIa77HK
	JUYpbf6+bZjr4D9wVOM8CHQMLxkFjhAYQlK9i3QlPzx7HntAiOiBvpGXtje6Phfw0DR8N+9DNYZ
	kSOLZC4EncSnbcCj/Rc15oc4O322rEw==
X-Google-Smtp-Source: AGHT+IF9pXrGXAAgfecgf8IV81urdTs2tFgEXc7oMGYoKuURBoKj0w8ltrhvl+JmU1IDFvfVQRDqqo4OF45Nh2mAZ60=
X-Received: by 2002:a05:6102:2acd:b0:47b:9547:bfde with SMTP id
 ada2fe7eead31-48077de57d5mr11124907137.13.1715689762418; Tue, 14 May 2024
 05:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514122337.1239800-1-sidchintamaneni@gmail.com>
In-Reply-To: <20240514122337.1239800-1-sidchintamaneni@gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 14 May 2024 08:29:11 -0400
Message-ID: <CAE5sdEi-_weDQdyWDJfaNLH9MsfvD0zR8Lj6-wJ+x0GFx6i4Tw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Added selftests to check
 deadlocks in queue and stack map
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 08:23, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> Added selftests to check for nested deadlocks in queue  and stack maps.
>
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__open 0 nsec
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__load 0 nsec
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__attach 0 nsec
> test_map_queue_stack_nesting_success:PASS:MAP Write 0 nsec
> test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
> test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
> 384/1   test_queue_stack_nested_map/map_queue_nesting:OK
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__open 0 nsec
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__load 0 nsec
> test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__attach 0 nsec
> test_map_queue_stack_nesting_success:PASS:MAP Write 0 nsec
> test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
> 384/2   test_queue_stack_nested_map/map_stack_nesting:OK
> 384     test_queue_stack_nested_map:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  samples/bpf/Makefile                          |   3 +

Somehow my test environment file got sneaked in. I will remove this
file and send a revised one for selftests.

>  .../prog_tests/test_queue_stack_nested_map.c  |  69 +++++++++++
>  .../bpf/progs/test_queue_stack_nested_map.c   | 116 ++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 9aa027b144df..9e1abf0e21ad 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -7,6 +7,7 @@ pound := \#
>
>  # List of programs to build
>  tprogs-y := test_lru_dist
> +tprogs-y += sid_queue_stack
>  tprogs-y += sock_example
>  tprogs-y += fds_example
>  tprogs-y += sockex1
> @@ -98,6 +99,7 @@ ibumad-objs := ibumad_user.o
>  hbm-objs := hbm.o $(CGROUP_HELPERS)
>
>  xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
> +sid_queue_stack-objs := sid_queue_stack_user.o
>
>  # Tell kbuild to always build the programs
>  always-y := $(tprogs-y)
> @@ -149,6 +151,7 @@ always-y += task_fd_query_kern.o
>  always-y += ibumad_kern.o
>  always-y += hbm_out_kern.o
>  always-y += hbm_edt_kern.o
> +always-y += sid_queue_stack_kern.o
>
>  TPROGS_CFLAGS = $(TPROGS_USER_CFLAGS)
>  TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
> new file mode 100644
> index 000000000000..fc46561788af
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "test_queue_stack_nested_map.skel.h"
> +
> +
> +static void test_map_queue_stack_nesting_success(bool is_map_queue)
> +{
> +       struct test_queue_stack_nested_map *skel;
> +       int err;
> +
> +       skel = test_queue_stack_nested_map__open();
> +       if (!ASSERT_OK_PTR(skel, "test_queue_stack_nested_map__open"))
> +               return;
> +
> +       err = test_queue_stack_nested_map__load(skel);
> +       if (!ASSERT_OK(err, "test_queue_stack_nested_map__load"))
> +               goto out;
> +
> +       skel->bss->pid = getpid();
> +       err = test_queue_stack_nested_map__attach(skel);
> +       if (!ASSERT_OK(err, "test_queue_stack_nested_map__attach"))
> +               goto out;
> +
> +       /* trigger map from userspace to check nesting */
> +       int value = 0;
> +
> +       do {
> +               if (is_map_queue) {
> +                       err = bpf_map_update_elem(bpf_map__fd(skel->maps.map_queue),
> +                                                               NULL, &value, 0);
> +                       if (err < 0)
> +                               break;
> +                       err = bpf_map_lookup_and_delete_elem(bpf_map__fd(skel->maps.map_queue),
> +                                                                NULL, &value);
> +               } else {
> +                       err = bpf_map_update_elem(bpf_map__fd(skel->maps.map_stack),
> +                                                               NULL, &value, 0);
> +                       if (err < 0)
> +                               break;
> +                       err = bpf_map_lookup_and_delete_elem(bpf_map__fd(skel->maps.map_stack),
> +                                                               NULL, &value);
> +               }
> +       } while (0);
> +
> +
> +       if (!ASSERT_OK(err, "MAP Write"))
> +               goto out;
> +
> +       if (is_map_queue) {
> +               ASSERT_EQ(skel->bss->err_queue_push, -EBUSY, "no map nesting");
> +               ASSERT_EQ(skel->bss->err_queue_pop, -EBUSY, "no map nesting");
> +       } else {
> +               ASSERT_EQ(skel->bss->err_stack, -EBUSY, "no map nesting");
> +       }
> +out:
> +       test_queue_stack_nested_map__destroy(skel);
> +}
> +
> +void test_test_queue_stack_nested_map(void)
> +{
> +       if (test__start_subtest("map_queue_nesting"))
> +               test_map_queue_stack_nesting_success(true);
> +       if (test__start_subtest("map_stack_nesting"))
> +               test_map_queue_stack_nesting_success(false);
> +
> +}
> +
> diff --git a/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c b/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
> new file mode 100644
> index 000000000000..893a37593206
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_STACK);
> +       __uint(max_entries, 32);
> +       __uint(key_size, 0);
> +       __uint(value_size, sizeof(__u32));
> +} map_stack SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_QUEUE);
> +       __uint(max_entries, 32);
> +       __uint(key_size, 0);
> +       __uint(value_size, sizeof(__u32));
> +} map_queue SEC(".maps");
> +
> +
> +int err_queue_push;
> +int err_queue_pop;
> +int err_stack;
> +int pid;
> +__u32 trigger_flag_queue_push;
> +__u32 trigger_flag_queue_pop;
> +__u32 trigger_flag_stack;
> +
> +SEC("fentry/queue_stack_map_push_elem")
> +int BPF_PROG(test_queue_stack_push_trigger, raw_spinlock_t *lock, unsigned long flags)
> +{
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) != pid)
> +               return 0;
> +
> +
> +       trigger_flag_queue_push = 1;
> +
> +       return 0;
> +}
> +
> +SEC("fentry/queue_map_pop_elem")
> +int BPF_PROG(test_queue_pop_trigger, raw_spinlock_t *lock, unsigned long flags)
> +{
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) != pid)
> +               return 0;
> +
> +       trigger_flag_queue_pop = 1;
> +
> +       return 0;
> +}
> +
> +
> +SEC("fentry/stack_map_pop_elem")
> +int BPF_PROG(test_stack_pop_trigger, raw_spinlock_t *lock, unsigned long flags)
> +{
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) != pid)
> +               return 0;
> +
> +       trigger_flag_stack = 1;
> +
> +       return 0;
> +}
> +
> +SEC("fentry/_raw_spin_unlock_irqrestore")
> +int BPF_PROG(test_queue_pop_nesting, raw_spinlock_t *lock, unsigned long flags)
> +{
> +       __u32 val;
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) != pid || trigger_flag_queue_pop != 1)
> +               return 0;
> +
> +
> +       err_queue_pop = bpf_map_pop_elem(&map_queue, &val);
> +
> +       trigger_flag_queue_pop = 0;
> +
> +       return 0;
> +}
> +
> +SEC("fentry/_raw_spin_unlock_irqrestore")
> +int BPF_PROG(test_stack_nesting, raw_spinlock_t *lock, unsigned long flags)
> +{
> +       __u32 val;
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) != pid || trigger_flag_stack != 1)
> +               return 0;
> +
> +
> +       err_stack = bpf_map_pop_elem(&map_stack, &val);
> +
> +       trigger_flag_stack = 0;
> +
> +       return 0;
> +}
> +
> +
> +SEC("fentry/_raw_spin_unlock_irqrestore")
> +int BPF_PROG(test_queue_push_nesting, raw_spinlock_t *lock, unsigned long flags)
> +{
> +       __u32 val = 1;
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) != pid || trigger_flag_queue_push != 1) {
> +               return 0;
> +       }
> +
> +       err_queue_push = bpf_map_push_elem(&map_queue, &val, 0);
> +
> +       trigger_flag_queue_push = 0;
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.44.0
>

