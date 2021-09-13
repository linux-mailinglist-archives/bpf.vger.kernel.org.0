Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD2B408A53
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbhIMLg0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 07:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239492AbhIMLgZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 07:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631532909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DWjMjXt3tKXT9y7/famTmIP//AvnKcUJfDsY/114QRY=;
        b=eH5V+8B9JeHkZSPQNjrJQr7/VZbmwQNsmSXjQWVrAmKLg3AcheLP17twze9L68mCxME4nW
        v9Jwo1MShhAQ6NI7NTH8V8NUOMZnZILBnjONr6FvcpFp2/87e6tCieqksaS0qN+22qf2gE
        QgPqOtrnOORe6sECkhoO0l+azvq5H1w=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-WDBrVrNdMn2Oj_Xhi1aDeQ-1; Mon, 13 Sep 2021 07:35:08 -0400
X-MC-Unique: WDBrVrNdMn2Oj_Xhi1aDeQ-1
Received: by mail-lf1-f72.google.com with SMTP id i40-20020a0565123e2800b003f53da59009so393273lfv.16
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 04:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DWjMjXt3tKXT9y7/famTmIP//AvnKcUJfDsY/114QRY=;
        b=j0RQbOxx0jtwfl0ypLHEvW2eUQqujq8J3BOKQ93o+mEbqWINh3gODOgxQUDvVndtuj
         3Ilt79p6G94SOXdfa1mOshDpJr3idha9YvdaxOSImhwKzZRaFjSunoW1eIQZAk23CBhy
         I8TSOYB0nFweCym+iim2AHiqqikXkyGmmCQGHm0vowCRDSWh/xUBoQDE9Ur0gbJlvZFv
         NX/10x0bO8NQL0LPDU0f+Lvwlc3EECYnyWOZ6v2SGIHq9SY9+sdKP50oyBKPO07uZntn
         J8xofWCxkx7ExtE3u0xm2ujHUK+QTvN0s8RLSy8jfsU1DkvV6xbqAi6lIuYOhQxVr8p1
         0ssg==
X-Gm-Message-State: AOAM531ypY3o+gHeXKr8UaRMvhKZZ6jV9B4vj5TMnCLFPCjfn7pOkWsK
        xMPz0oUJpdbbrOOan1N6hJaWXMD/58aj08rBGpIQqmVt2/5NftkR2sMGbBTQtVersX/sbggblXO
        IJHSLVTQEESqX
X-Received: by 2002:ac2:5ded:: with SMTP id z13mr8793115lfq.428.1631532906906;
        Mon, 13 Sep 2021 04:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXewiNcd/iT983C4OrQ+1fTOhPFXrpuV3hE6k2dPYw/EE3yDUKBt/f1n56/OZuJVHfFyKbHQ==
X-Received: by 2002:ac2:5ded:: with SMTP id z13mr8793103lfq.428.1631532906723;
        Mon, 13 Sep 2021 04:35:06 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id n25sm949531ljj.42.2021.09.13.04.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 04:35:06 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Toke Hoiland Jorgensen <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        Alexander Lobakin <alobakin@pm.me>
Subject: XDP-hints as BTF early design discussion phase
Message-ID: <6850bdde-b660-5ed3-9749-2fc6c1c1d0b7@redhat.com>
Date:   Mon, 13 Sep 2021 13:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trying to get started with XDP-hints again.

The fundamental idea is that XDP-hints metadata struct's are defined by 
the kernel, preferably by the kernel module, and described via BTF. As 
BTF layout is defined by kernel, this means userspace (AF_XDP) and 
BPF-progs must adapt to layout (used by running kernel). This imply that 
kernel is free to change layout.

The BTF ID is exposed (to BPF-prog and AF_XDP) on per packet basis, to 
give kernel more freedom to change layout runtime. This push 
responsibility to userspace/BPF-prog of handling different layouts, 
which seems natural. For the kernel this solves many issues around 
concurrency and NIC config changes that affects BTF info available (e.g. 
when BTF layout is allowed to change).

End-goal is to make it easier for kernel drivers can invent new layouts 
to suite new hardware features. Thus, we prefer a solution where 
XDP-hints metadata struct's are defined in the kernel module code.


(Idea below ... please let us know what you think, wrong direction?)

Exploring kernel module code defining the XDP-hints metadata struct.

Kernel module BTFs are now[1][2] exposed through sysfs as 
/sys/kernel/btf/<module-name>. Thus, userspace can use libbpf 
btf__load_module_btf() and others BTF APIs. Started playing here[3].

Credit to Toke, who had an idea that drivers could "say" what struct's 
are available, by defining a union with a known name e.g. 
metadata_hints_avail' and have supported metadata struct's included in 
that union. Then we don't need new APIs for exporting these BTF-metadata 
struct's. To find struct names, we BTF walk this union.


-Jesper

  [1] 
https://lore.kernel.org/bpf/20201110011932.3201430-5-andrii@kernel.org/
  [2] 36e68442d1af ("bpf: Load and verify kernel module BTFs") (Author: 
Andrii Nakryiko)
  [3] 
https://github.com/xdp-project/bpf-examples/blob/master/BTF-playground/


