Return-Path: <bpf+bounces-11374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60F7B809E
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 15:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8A86D281A12
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 13:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F114297;
	Wed,  4 Oct 2023 13:17:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0771426E;
	Wed,  4 Oct 2023 13:17:50 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCA9E;
	Wed,  4 Oct 2023 06:17:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-417fa15f1f9so3148991cf.1;
        Wed, 04 Oct 2023 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696425467; x=1697030267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n1bKjfKvQwptdiOYowTerT/x+Zwo88jDUmSOGNk+Iq4=;
        b=LS+30STI4vrqAxt7uOuqFp7deZF4om8hBweFrNUyOdbfvwH1by1djOTYhq5xxjkQpj
         WYWf2bUemnpck4wYENMPvkFaBVgc0RwQiJFTxy56/hqSZ1DN8fydydEZXYXtKzlqFZ4g
         Q9H8YItDuVc6JKr1DnKu8FwmeXn/zibOF3/fbWGtp50uvEUMFoLKpnimFmWnOnmaJkMj
         JvlMV+EKd4mrEEyp4MfMarajNK0Lj5CK2mN9MRaTY3YghxAIDUJNFwPT6wKqD4HLHXKB
         YuIc9TqUvFx1Wt2lleUoaWKKO1XL4MVUv1CdMawb/mql6XfGCZnN1hms5wUVJIovfcBh
         +2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425467; x=1697030267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1bKjfKvQwptdiOYowTerT/x+Zwo88jDUmSOGNk+Iq4=;
        b=sNfFaoufLvEbc48FNukM2+juA3ltnoy3V1dLmVLIIzYhzLddDulSpsuWhNJAJK7xC4
         1A3aFRM2BjBpHv1OxkNa4/4yEDYzRPIrqkOsgN2GJvwoP21x7siiGSlR3Hb9FVewG6AV
         /qssOpJDlXou663PfrbLZCZkSfLTDd5Rv9RKZpjH7JSRj0EcitYqbro01XRjcRkUiD2K
         Mh1cx8h9CqlF/Wb/ilVphU+rOUeq4LHdSYyNCNU0XJUEXo1QTW4XGFECJYf8RMEeIU3v
         nt7WQHVwnPbh+Qi4MdmWZpmX2VZEEsirRDAu6kAmEo6V5kHQgXOcUUViftN0+Uw0wifp
         jp3g==
X-Gm-Message-State: AOJu0YwiTEmgjvTkqaohy6jlVZoJgElzpnEtOF3W++j+0AcqrfaYA+IY
	NPOYOkoHzQb+G5ayYhpIlbffyfuNBs9pajZ6UtatARLr0S6Tl+Wo
X-Google-Smtp-Source: AGHT+IEGdMEnKUqe9/DK5OjlOZrI/GVNqeopvzGplbFLAI/+kfL0aYj76n4iXQlBWuidbP6eViQ5ApeG9zjljMrzo0A=
X-Received: by 2002:a05:6214:519b:b0:65d:482:9989 with SMTP id
 kl27-20020a056214519b00b0065d04829989mr2299201qvb.5.1696425467657; Wed, 04
 Oct 2023 06:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
In-Reply-To: <20230927135241.2287547-1-tushar.vyavahare@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 4 Oct 2023 15:17:36 +0200
Message-ID: <CAJ8uoz0ebFd+S+uNNDGde=KtG1NK8ut2QQ=aeM9SrOY_1fUh_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/8] Add a test for SHARED_UMEM feature
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

On Wed, 27 Sept 2023 at 15:31, Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Implement a test for the SHARED_UMEM feature in this patch set and make
> necessary changes/improvements. Ensure that the framework now supports
> different streams for different sockets.
>
> v2->v3
> - Set the sock_num at the end of the while loop.
> - Declare xsk at the top of the while loop.
>
> v1->v2
> - Remove generate_mac_addresses() and generate mac addresses based on
>   the number of sockets in __test_spec_init() function. [Magnus]
> - Update Makefile to include find_bit.c for compiling xskxceiver.
> - Add bitmap_full() function to verify all bits are set to break the while loop
>   in the receive_pkts() and send_pkts() functions.
> - Replace __test_and_set_bit() function with __set_bit() function.
> - Add single return check for wait_for_tx_completion() function call.
>
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

Thanks Tushar!

For the set:
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

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

