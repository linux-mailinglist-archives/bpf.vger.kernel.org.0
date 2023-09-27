Return-Path: <bpf+bounces-10947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF487AFDF6
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 10:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 83875283D27
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF51D6A3;
	Wed, 27 Sep 2023 08:14:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CC1D693;
	Wed, 27 Sep 2023 08:14:46 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D40CCE;
	Wed, 27 Sep 2023 01:14:26 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-637aaaf27f1so15742296d6.0;
        Wed, 27 Sep 2023 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695802466; x=1696407266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YOpcy6dbJ2FwJav3T6JFtntTKeeJFyNITVX/9PBeOz8=;
        b=UJnYO51OMBe8X8ieakyg3l0YBaOKCB/g4ir3ilbtEjO9VVWcGs3UB25uskRfWxwHlY
         WajqD63Us+F41GamM4Vkfdzh1gt29NBFgns/p3Jcl5OXtVz3s1waGhVWzK62XSZJephL
         Z7ZhFqBRqO8f9UsFA2GQjO9AEfDAmIfPzw+68Wy7RH4tCE4bXiYjgThZD3p8A1kEu1sS
         aDrpCHDcl0DRmPxIJYtV6vWWaF7QiKVzvMrC9MtY1SBf0SoVMcAwlS8ljKf63ZwjWGqq
         9tjrK2PqRJW0t6MQcHlJppeE+u6ZeswRDv0VLdjpCiEEw8aEc0zEire7UL31oE/kRcNz
         jcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695802466; x=1696407266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOpcy6dbJ2FwJav3T6JFtntTKeeJFyNITVX/9PBeOz8=;
        b=poPXYvdUSb1q0vaUg5jJ4wUMFVk6WkYdFPktsaFFzW0ArYru/g9Wd3ntR5qHuCnkWY
         8xnBCPEbIOCGM2HyIE/5blaRI7wc/rhPjTu0q/glXH5sfnYYpPq5K13WG/exC+YLfp9l
         gFHo6zkf5P0OUyeTS93oB9Nvo8NljuvdOKVoMljQm57bqYR8WaBU6UnnkbQJHoFjE6/5
         9EYSeSigBfY9fngeD86hos+l1YvALQ49bFrPpSQcAuxcUqgVFvVPEQdJJ3gUgwTNMRte
         q9qbLwCa2YL8NvrN07IpgXJCFb57WeOHblnoC8ygbCvaLKEJwPtj0NprBawxV31bJ/0l
         019w==
X-Gm-Message-State: AOJu0Yz4ymceDBUaMbHBodj9gj0Q+ZpTMaBKGaRTf3Capi96oKqIhHDE
	BiJMS4/bF7phwWm8O6JhD9UkSGHzjS870kga+Nk=
X-Google-Smtp-Source: AGHT+IGQUuta4tOsbPD+KW0+eENuBGbKuJtmRZ04PiSvxOWNw1/ZT0x+aMQpjmnRZY289EvujRnbhvX2wWt/LyPdSDQ=
X-Received: by 2002:ad4:5ba6:0:b0:658:30c4:206 with SMTP id
 6-20020ad45ba6000000b0065830c40206mr1479980qvq.0.1695802465764; Wed, 27 Sep
 2023 01:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925102249.1847195-1-tushar.vyavahare@intel.com>
In-Reply-To: <20230925102249.1847195-1-tushar.vyavahare@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 27 Sep 2023 10:14:14 +0200
Message-ID: <CAJ8uoz0o1Are-qFZzsxuNhjZM4MREZLTPNJwToYhciiWuEuChA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/8] Add a test for SHARED_UMEM feature
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 25 Sept 2023 at 12:01, Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Implement a test for the SHARED_UMEM feature in this patch set and make
> necessary changes/improvements. Ensure that the framework now supports
> different streams for different sockets.
>
> v1->v2
>         - Remove generate_mac_addresses() and generate mac addresses based on
>           the number of sockets in __test_spec_init() function. [Magnus]
>         - Update Makefile to include find_bit.c for compiling xskxceiver.
>         - Add bitmap_full() function to verify all bits are set to break the while loop
>           in the receive_pkts() and send_pkts() functions.
>         - Replace __test_and_set_bit() function with __set_bit() function.
>         - Add single return check for wait_for_tx_completion() function call.

Just two things to fix in patch #4. Please send a v3 and then you have
my ack for the set. Thank you!

> Patch series summary:
>
> 1: Move the packet stream from the ifobject struct to the xsk_socket_info
>    struct to enable the use of different streams for different sockets
>    This will facilitate the sending and receiving of data from multiple
>    sockets simultaneously using the SHARED_XDP_UMEM feature.
>
>    It gives flexibility of send/recive individual traffic on particular
>    socket.
>
> 2: Rename the header file to a generic name so that it can be used by all
>    future XDP programs.
>
> 3: Move the src_mac and dst_mac fields from the ifobject structure to the
>    xsk_socket_info structure to achieve per-socket MAC address assignment.
>    Require this in order to steer traffic to various sockets in subsequent
>    patches.
>
> 4: Improve the receive_pkt() function to enable it to receive packets from
>    multiple sockets. Define a sock_num variable to iterate through all the
>    sockets in the Rx path. Add nb_valid_entries to check that all the
>    expected number of packets are received.
>
> 5: The pkt_set() function no longer needs the umem parameter. This commit
>    removes the umem parameter from the pkt_set() function.
>
> 6: Iterate over all the sockets in the send pkts function. Update
>    send_pkts() to handle multiple sockets for sending packets.
>    Multiple TX sockets are utilized alternately based on the batch size
>    for improve packet transmission.
>
> 7: Modify xsk_update_xskmap() to accept the index as an argument, enabling
>    the addition of multiple sockets to xskmap.
>
> 8: Add a new test for testing shared umem feature. This is accomplished by
>    adding a new XDP program and using the multiple sockets. The new  XDP
>    program redirects the packets based on the destination MAC address.
>
> Tushar Vyavahare (8):
>   selftests/xsk: move pkt_stream to the xsk_socket_info
>   selftests/xsk: rename xsk_xdp_metadata.h to xsk_xdp_common.h
>   selftests/xsk: move src_mac and dst_mac to the xsk_socket_info
>   selftests/xsk: iterate over all the sockets in the receive pkts
>     function
>   selftests/xsk: remove unnecessary parameter from pkt_set() function
>     call
>   selftests/xsk: iterate over all the sockets in the send pkts function
>   selftests/xsk: modify xsk_update_xskmap() to accept the index as an
>     argument
>   selftests/xsk: add a test for shared umem feature
>
>  tools/testing/selftests/bpf/Makefile          |   4 +-
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  22 +-
>  tools/testing/selftests/bpf/xsk.c             |   3 +-
>  tools/testing/selftests/bpf/xsk.h             |   2 +-
>  tools/testing/selftests/bpf/xsk_xdp_common.h  |  12 +
>  .../testing/selftests/bpf/xsk_xdp_metadata.h  |   5 -
>  tools/testing/selftests/bpf/xskxceiver.c      | 513 +++++++++++-------
>  tools/testing/selftests/bpf/xskxceiver.h      |  13 +-
>  8 files changed, 363 insertions(+), 211 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/xsk_xdp_common.h
>  delete mode 100644 tools/testing/selftests/bpf/xsk_xdp_metadata.h
>
> --
> 2.34.1
>
>

