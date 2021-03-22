Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9878344FF8
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 20:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhCVThE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 15:37:04 -0400
Received: from wforward2-smtp.messagingengine.com ([64.147.123.31]:40465 "EHLO
        wforward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231761AbhCVTg6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Mar 2021 15:36:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailforward.west.internal (Postfix) with ESMTP id 21FD817BE;
        Mon, 22 Mar 2021 15:36:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 Mar 2021 15:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=zBi/FX7O/1QR6Iat/TWQtBJXPkXI9xfrAi8JtO0QD
        1o=; b=vrPD0uz4fGh3zennGghdgOXuAzkqUPRokp3pPVAeBJB3aQ4H30jI5qV4V
        ZOrZWFSiqdqvyZb0hKgJSZo7nOGPk1rBHXT3qfGVtSqOb69ERZTyjOCBadb3IBcy
        2H2Y3U7EKcZmXGpxoz3x0ehC58XZhYCIh/+vNozjjFgMTjepO0vA4Z/+AcUOQbw3
        NOStlXv1U2ZJ17MVGgMsJYebV7kzvRzsN94vJkOtDyaLQgYWGhoI5qjpf6Flw6uf
        m3HHNakd4/ECmfgr/ltAlsfSpxN9mGKyeu5IOaYyWtYHnM6LGtk+OdkKoLe5/vGv
        SlFuE9o0C404HaXYRCdjQ8m9WqH6Q==
X-ME-Sender: <xms:2PFYYNvDxq-m3WZj1XYoBnxpowe9m7DXmtaJWq5gd7wqHCZR-OzA_w>
    <xme:2PFYYGan8UtWPvKW9pNZHcQRKODs8akUmiuExL-yuKUmq1fqE1bRp8P7cWwQw4a3Q
    B3D6TuypARM__lA4_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuphgrmhfkphdqohhuthculdehtddtmdenucfjughrpegtggfuhfgjfffgkfhfvffo
    sehtkehmtdhhtdejnecuhfhrohhmpeftrghfrggvlhcuffgrvhhiugcuvfhinhhotghouc
    eorhgrfhgrvghlughtihhnohgtohesuhgsuhhnthhurdgtohhmqeenucggtffrrghtthgv
    rhhnpeeihfetudegteeuveevkeffjeffffehtdekkeefjeetfefgfeduleekteffgfelue
    enucfkphepudeluddrleeirddufedrvddufeenucfuphgrmhfkphepudeluddrleeirddu
    fedrvddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrrghfrggvlhguthhinhhotghosehusghunhhtuhdrtghomh
X-ME-Proxy: <xmx:2PFYYNrfdtkCafq_x8FsCVM5W3Z8JcjUqsoIVDSIacgOUyXeiaiXlQ>
    <xmx:2PFYYL8YXo_VHgB1eRGbeVGgP3qEj14KQ8-w7BkiqVaKuoBhP2ZAQg>
    <xmx:2PFYYM8sXxaJjBQb3nWOpXT6viubkdMI97j3ef24O-B7OHkIYYgryQ>
    <xmx:2PFYYPkLgk66sWcPRUjXIflKLeYlu4cMUSvVuLc3CfZv9LI_aWng0AJfscFaIF2W>
Received: from [10.6.2.232] (unknown [191.96.13.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA62F240425;
        Mon, 22 Mar 2021 15:36:55 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 bpf-next] libbpf: add bpf object kern_version attribute
 setter
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4BzbUaDbhd4zzfpzpHS007hT+uyQyifdzCdD8_Rwp6ydhfQ@mail.gmail.com>
Date:   Mon, 22 Mar 2021 16:36:51 -0300
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
X-Mao-Original-Outgoing-Id: 638134611.457257-7e8ebde873324bdb08c95fe41648b342
Content-Transfer-Encoding: 8bit
Message-Id: <4867B26C-E650-451B-9103-2FFB99DD03C4@ubuntu.com>
References: <20210320202821.3165030-1-rafaeldtinoco@ubuntu.com>
 <CAEf4BzbUaDbhd4zzfpzpHS007hT+uyQyifdzCdD8_Rwp6ydhfQ@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> +LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32  
>> kern_version);
>
> have you run libbpf's Makefile? It should have complained about
> bpf_object__set_kversion symbol mismatches/etc. That means that this
> API needs to be listed in libbpf.map file, please add it there (to
> latest version, 0.4, and also preserve alphabetical order). Thanks.

Alright, sending a v3 with changes. I had only static builds on
my side and it didn’t run assigned linker version-script. Will
include in my tests before further submissions.



