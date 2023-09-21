Return-Path: <bpf+bounces-10553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371EE7A9C69
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA74B21297
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123547C84;
	Thu, 21 Sep 2023 17:49:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980141754;
	Thu, 21 Sep 2023 17:49:36 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74380FA9;
	Thu, 21 Sep 2023 10:36:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3adcae1e9f6so192352b6e.0;
        Thu, 21 Sep 2023 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317815; x=1695922615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pk82zE/dtTZn+xATdDbyMFOaczKW9JrERtnmCSdw+Lw=;
        b=K4fg/8EHy+db4DQwoccC36mU1NqhJrKF/eYhzZ/UrewFXqNgXjDkCb/Iw0ZQzQnhcI
         hKQm0ma5kXGzb/ZZ8Ec8TdyOH9Hr6Cqx/eA2wPkGYxkvLXdJWJ7k2Y8zOxouzE3rz2vf
         bs9UNPDNuiCSiH1zydn7vFPs5HbtpjJRdECtvBQT3Hen97Mb2i4VpCzHLN47muogkAUG
         hxwytAvbI9MS7GNJTiY6Lq+fBl5i4d1NdwO50jbqTpqq7HLCUry81rU/wYau9iY1J8A5
         oqdh6yvcIjXAa2bibsrI5JUIy8nARKMCYOvZZoBXk+sWk2ieLfBfKK3MunkP4FzBuE0F
         5IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317815; x=1695922615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk82zE/dtTZn+xATdDbyMFOaczKW9JrERtnmCSdw+Lw=;
        b=QB4fnx0UygWNMPRQXxXQI34a/tQJ/KYVSa1D6HyPLQebI9pZr2KCpdQya5vtWrU58V
         ZSMTpJbH0EIomkwQTKzAZ8IqVprciAKVn8mzys8l6pLnKWlt/jRU4Ud90THkOyf4rf0S
         SGa6wd0sNVfgRiJPCdMni7pOFFwsWsRnSRF973aU3eSpe5NGzP5WjBd3FXdxfHw1rj4W
         EErnyUgUbXD0SPqe77zJbBcIME2WtDfAH2bks93DhGyywrUA5htm+BqgoIsA7RpVNCh/
         /DH6zAPyCe4zfPyZ/I+WKmNHdQihpzCj/rP4pBLKAXA8NiflfKfkT1nZDuJx+02Yd7LK
         YG5w==
X-Gm-Message-State: AOJu0Ywcg0nwa6wsTGVr+E0MN6cWuMR670TtkNVT/3PHTMo/C57KSpxP
	KCWEST7n/Y2k7zhdQ29WTMp+iDC2KfKzyvSjkGDDzgkFTdTtng==
X-Google-Smtp-Source: AGHT+IHRvPDDapKsyXA/SXd3CeM8A0NfCkA/x3l/6T/asTQkDelvkWybsb2S6lb8D13HUDymbyk5ECSsrtYyLldm3x0=
X-Received: by 2002:a05:6214:5001:b0:656:2e07:94cc with SMTP id
 jo1-20020a056214500100b006562e0794ccmr4570370qvb.6.1695281327519; Thu, 21 Sep
 2023 00:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918093304.367826-1-tushar.vyavahare@intel.com>
In-Reply-To: <20230918093304.367826-1-tushar.vyavahare@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 21 Sep 2023 09:28:36 +0200
Message-ID: <CAJ8uoz3XiM=bKrEvfnb_y6TJv53R8-bkY1e2L0Tiad6uoTaTwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] Add a test for SHARED_UMEM feature
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sept 2023 at 11:12, Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Implement a test for the SHARED_UMEM feature in this patch set and make
> necessary changes/improvements. Ensure that the framework now supports
> different streams for different sockets.

Thanks Tushar for contributing this new test. Had some comments in
three of the patches. Please take a look.

/Magnus

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
>    Implement the function called generate_mac_addresses() to generate MAC
>    addresses based on the required number by the framework.
>
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
>   selftests/xsk: implement a function that generates MAC addresses
>   selftests/xsk: iterate over all the sockets in the receive pkts
>     function
>   selftests/xsk: remove unnecessary parameter from pkt_set() function
>     call
>   selftests/xsk: iterate over all the sockets in the send pkts function
>   selftests/xsk: modify xsk_update_xskmap() to accept the index as an
>     argument.
>   selftests/xsk: add a test for shared umem feature
>
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  22 +-
>  tools/testing/selftests/bpf/xsk.c             |   3 +-
>  tools/testing/selftests/bpf/xsk.h             |   2 +-
>  tools/testing/selftests/bpf/xsk_xdp_common.h  |  12 +
>  .../testing/selftests/bpf/xsk_xdp_metadata.h  |   5 -
>  tools/testing/selftests/bpf/xskxceiver.c      | 524 +++++++++++-------
>  tools/testing/selftests/bpf/xskxceiver.h      |  14 +-
>  7 files changed, 376 insertions(+), 206 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/xsk_xdp_common.h
>  delete mode 100644 tools/testing/selftests/bpf/xsk_xdp_metadata.h
>
> --
> 2.34.1
>
>

