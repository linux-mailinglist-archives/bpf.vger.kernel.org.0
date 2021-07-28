Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8D03D8F9E
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhG1NvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 09:51:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:65514 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236945AbhG1Ntv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 09:49:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212391343"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="212391343"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 06:47:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="517461662"
Received: from unknown (HELO localhost.localdomain) ([10.102.102.63])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 06:47:26 -0700
Date:   Wed, 28 Jul 2021 05:54:13 -0400
From:   Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     BPF-dev-list <bpf@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Subject: XDP-hints: how to inform driver about hints
Message-ID: <YQEpRRxxf0R4Znd3@localhost.localdomain>
References: <20210526125848.1c7adbb0@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526125848.1c7adbb0@carbon>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi

I have just stareted working on generic hints implementation that was
discussed on netdev workshop. I wondering how we should tell driver that
hints is supported on XDP program.

I prepared 3 implementation of this approach. In 1 and 3 solution I
wanted to automatically search for hints usage in XDP program, but it
doesn't look good because of comparing lines of XDP program in libbpf
(3) or in bpf core (1).

For me solution 2 with reusing XDP flags looks good, but I don't
know if XDP flags can be used for storing information about hints.
What do you guys think about that?

Please take a look at code samples:

(1)
https://github.com/alobakin/linux/commit/a4f32ba74e5d3eefe607789547e9d5529ed775b0
don't know how to send flag to driver. Searching for metadata happens
in load program path, but communication with driver
(by ndo_bpf call happens in creating link)

(2)
https://github.com/alobakin/linux/commit/72a5d930bea330f5f4827fdf098b723f96acff0c
simplest solution. Add another flag, everything are there, driver will
check this flag in ndo_bpf

(3)
https://github.com/alobakin/linux/commit/92de1e0e3523317c5749f3c87173dc90b1e8011b
I haven't tested it yet. I think it is doable to do this search in creating
link path, but only when user uses syscall instead of netlink API
(I am pretty sure that this is used in auto generated code by libbpf).
If we will decide that this solution can be correct I will write a suitable
sample and chec if this works
