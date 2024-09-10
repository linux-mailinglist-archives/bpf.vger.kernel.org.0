Return-Path: <bpf+bounces-39432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52506973671
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E569EB21998
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D51F18EFE6;
	Tue, 10 Sep 2024 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7GRZuMN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEC18785A;
	Tue, 10 Sep 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968929; cv=none; b=kss9sJEtjVTwrbDb9o2qQBqKI40bYpRw1x8iTkxwiypZ3Udf7FhJXM/W9VD628Uk4+YuyydR0881jOLLCsSdH849sCRwideiZzjoMSwVRABaieZTh4P4LZmhVm+gF9Me2w78SnVM0olQ8hOV1actPfA9vtzQqbIqJuoy/sgHByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968929; c=relaxed/simple;
	bh=npn/eIxIYULWPbC6MYWbSO7IPp8KK8bF2OXku0SL/Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITB0MRPCSJxeSK4Pazn/PmgY+35on0KiXdFZa0HxPlOmff+o78lUb0QH7LyR7LoLzLFX+Vi11VBuhdaF5R0Qlxm3YJP90oGaqYiR5KNQnuWRszo9leDHKnSQwU6yU3+WCLKy4NN2NzCHa0UQA7YV2ra7KyFgqj1u9iqHXICCgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7GRZuMN; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a95efbaf49so405486785a.3;
        Tue, 10 Sep 2024 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725968926; x=1726573726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VROXDVbJIh17akuJg/pwqxOyHIw+9/+jX9gxEN61V90=;
        b=P7GRZuMNnLK1ljNKC3+XjrRyBrX1WIYRakyCYYDIrXMt2pxl0qeNBTwzwBW+iH3B0u
         kQ50ijq39C3yL/TNPyZsX1mbVeIM5qUURPt5C4bwUWSGhxzC7dL5brkPHFmsvfB8TuvA
         GownpUIffwN52L7cvL2iD5oyFIvvyu4nKqqv31Yz4cmFaf4uEqP8MouqwjBthUQkZ+wu
         v24NWWStZtc2j+GaHXLyJmjPlBTKPW9teSbE/zCqfXi4c1actUwb1twvScmgMLhjiuK+
         YRkCsMpqP60HlCAhUG8HmRct/ru1d/6/gyuWJJklBXLJBx1cm3lQ/VAPQsPrQP++D1bl
         nwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725968926; x=1726573726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VROXDVbJIh17akuJg/pwqxOyHIw+9/+jX9gxEN61V90=;
        b=rlv/QS4dSIzSy4kwFi85J5k7PA0cBvPphs3IAd71KHDGGbTyz61PkjyJgmUDBHjmsZ
         MXdUNTifHHqYHAzPcpEPgqsQ/+eaQSxGahITm2ek4MjiVdS/i6276UkwiHt9FQq1NWCC
         Girjk3YtURp4mxGBbGnCLZXcuAgKLECDtto22FftN8cQTMJHZSx2Tyxy/2XePVugFEbH
         CyI52QUVL9cnoZ/Jj3+CkOE/3sQr0sNdgmXF8MMhNcQ/Ioa6aju0m7dHDF4WfJhW45FC
         pqBjmG7xiOqcF3m4djWy+gWaHRli02+83Xewbjqxrg7N6SkbD0PnpGzKK/Y1/YNlr8ZC
         hCgA==
X-Forwarded-Encrypted: i=1; AJvYcCXC6oWIVEeGc2TShLI8F0J/qrvfpz9h+I8pFiE9bukmVxMyY3LhGllwFM53fw29R1nZLohGq+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmnCtkpPx2bhd6+gwsNdUu8VLoP1qKWtYrNIwQuo//IIVEUHs
	i+qL3DSq6hQSNE1Bs5kFRHdv6/ZBwkB6jjB7pgcMoVFSk8pEW0TxiLnpuCgk+xBYbHzyZ+pn+61
	vQJsIFJk4EZpSn7WkJOHAgr+dk8A=
X-Google-Smtp-Source: AGHT+IH225kvywVs5DBrVfEYFzzA+uf7MS2iLzVyi4pGhuUZi9NbKQVNisAXx3iTU4BEdfsv0/Ef9g0T/FYx18HYOfY=
X-Received: by 2002:a05:6214:4607:b0:6c3:5926:a070 with SMTP id
 6a1803df08f44-6c5284f4c8cmr226810156d6.30.1725968926255; Tue, 10 Sep 2024
 04:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909141110.284967-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240909141110.284967-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 10 Sep 2024 13:48:35 +0200
Message-ID: <CAJ8uoz0BDJ=y-5M3=Wrz7F1LtT8AUVCyNh1G88SaKv+yEYL-Bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: xsk: read current MAX_SKB_FRAGS from
 sysctl knob
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 16:12, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Currently, xskxceiver assumes that MAX_SKB_FRAGS value is always 17
> which is not true - since the introduction of BIG TCP this can now take
> any value between 17 to 45 via CONFIG_MAX_SKB_FRAGS.
>
> Adjust the TOO_MANY_FRAGS test case to read the currently configured
> MAX_SKB_FRAGS value by reading it from /proc/sys/net/core/max_skb_frags.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 41 +++++++++++++++++++++---
>  tools/testing/selftests/bpf/xskxceiver.h |  1 -
>  2 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 92af633faea8..595b6da26897 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -325,6 +325,25 @@ static bool ifobj_zc_avail(struct ifobject *ifobject)
>         return zc_avail;
>  }
>
> +#define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
> +static unsigned int get_max_skb_frags(void)
> +{
> +       unsigned int max_skb_frags = 0;
> +       FILE *file;
> +
> +       file = fopen(MAX_SKB_FRAGS_PATH, "r");
> +       if (!file) {
> +               ksft_print_msg("Error opening %s\n", MAX_SKB_FRAGS_PATH);
> +               return 0;
> +       }
> +
> +       if (fscanf(file, "%u", &max_skb_frags) != 1)
> +               ksft_print_msg("Error reading %s\n", MAX_SKB_FRAGS_PATH);
> +
> +       fclose(file);
> +       return max_skb_frags;
> +}
> +
>  static struct option long_options[] = {
>         {"interface", required_argument, 0, 'i'},
>         {"busy-poll", no_argument, 0, 'b'},
> @@ -2245,13 +2264,22 @@ static int testapp_poll_rxq_tmout(struct test_spec *test)
>
>  static int testapp_too_many_frags(struct test_spec *test)
>  {
> -       struct pkt pkts[2 * XSK_DESC__MAX_SKB_FRAGS + 2] = {};
> +       struct pkt *pkts;
>         u32 max_frags, i;
> +       int ret;
>
> -       if (test->mode == TEST_MODE_ZC)
> +       if (test->mode == TEST_MODE_ZC) {
>                 max_frags = test->ifobj_tx->xdp_zc_max_segs;
> -       else
> -               max_frags = XSK_DESC__MAX_SKB_FRAGS;
> +       } else {
> +               max_frags = get_max_skb_frags();
> +               if (!max_frags)
> +                       return TEST_FAILURE;

Thanks for this fix Maciej. However, I think failing the test here is
a little bit too drastic. How about just returning TEST_SKIP and print
out that the max number of skbs is unknown as the reason for the skip?
Or even more optimistically, print out a warning that we could not
read the max number of skb but we are guessing 17 and then run the
test? If it passes, great we guessed correctly, but if it fails we are
not worse off than the current code. Do not know how often a file
system does not contain /proc/sys/net/core/max_skb_frags though.

> +               max_frags += 1;
> +       }
> +
> +       pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
> +       if (!pkts)
> +               return TEST_FAILURE;
>
>         test->mtu = MAX_ETH_JUMBO_SIZE;
>
> @@ -2281,7 +2309,10 @@ static int testapp_too_many_frags(struct test_spec *test)
>         pkts[2 * max_frags + 1].valid = true;
>
>         pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2);
> -       return testapp_validate_traffic(test);
> +       ret = testapp_validate_traffic(test);
> +
> +       free(pkts);
> +       return ret;
>  }
>
>  static int xsk_load_xdp_programs(struct ifobject *ifobj)
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 885c948c5d83..e46e823f6a1a 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -55,7 +55,6 @@
>  #define XSK_UMEM__LARGE_FRAME_SIZE (3 * 1024)
>  #define XSK_UMEM__MAX_FRAME_SIZE (4 * 1024)
>  #define XSK_DESC__INVALID_OPTION (0xffff)
> -#define XSK_DESC__MAX_SKB_FRAGS 18
>  #define HUGEPAGE_SIZE (2 * 1024 * 1024)
>  #define PKT_DUMP_NB_TO_PRINT 16
>  #define RUN_ALL_TESTS UINT_MAX
> --
> 2.34.1
>
>

