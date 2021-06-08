Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4013C3A075A
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 01:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFHXCw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 19:02:52 -0400
Received: from mail-qk1-f225.google.com ([209.85.222.225]:45720 "EHLO
        mail-qk1-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFHXCw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 19:02:52 -0400
Received: by mail-qk1-f225.google.com with SMTP id d196so16824336qkg.12
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 16:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:from:date:message-id
         :subject:to;
        bh=rQsS/+0X53LEEP70QVyIkN/HKVhtBIJuAicCKzCwY60=;
        b=Zh+KyOX8W8kCLj2yS8xfa7iW6J0G8qSAq6SDkkH9RYTFCdIh2vXs2JgQxFD4lUvske
         fsrMkyPKD+oD5BDMhf+Mi3Cbu1gDF6Xi2EKOCK3Q5CgkWZ5yMJW6ELslyu/t5yqqL3RI
         H12QbitypdjWYW3qZvp7Hdrqo0wdNHnpXqRFXJR1u6JOxMymB1cXNEWz9gqxMVKnKtDK
         aPN8+6FWKfzx16KF8dtuzTtwCEaK3J2epRkG0PglWmBIglOjX65oMwSO8evgiyxoUCiE
         k9eQDC/2gjhZJUl5L8ENe4KeKwAyrbAbbgM2uXSRv8ihgbsNyhzr+jpllIk0W6ykMoCO
         y+Uw==
X-Gm-Message-State: AOAM530eEsZA2xDjye+ro37Rq6Ca+SQFGYaQwh4ger+gtAne3tKfxBbQ
        lEtrCk5xEG+X2kiZzkBAbOCp4qgGR3HeNIkXQTizEnxRUUtzqw==
X-Google-Smtp-Source: ABdhPJyLX1S2kWzDqufcLw+8kV7d9u20qQAGQvwUTj1ycRSolfO5MmcfKusgTe5oVx2ipnnJ+Q8kuKCD8xRM
X-Received: by 2002:a05:620a:1368:: with SMTP id d8mr24531087qkl.283.1623193189765;
        Tue, 08 Jun 2021 15:59:49 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.44])
        by smtp-relay.gmail.com with ESMTPS id x1sm7109938qkn.6.2021.06.08.15.59.49
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 15:59:49 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.45)
    by restore.menlosecurity.com (13.56.32.44)
    with SMTP id 3939f890-c8ad-11eb-bd31-53b93506b29b;
    Tue, 08 Jun 2021 22:59:49 GMT
Received: from mail-ed1-f69.google.com (209.85.208.69)
    by safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.45)
    with SMTP id 3939f890-c8ad-11eb-bd31-53b93506b29b;
    Tue, 08 Jun 2021 22:59:49 GMT
Received: by mail-ed1-f69.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso11584736edd.12
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=rQsS/+0X53LEEP70QVyIkN/HKVhtBIJuAicCKzCwY60=;
        b=gMsQ7n/vUIXm3yPpVRQcloVv0hN6BoQikr+/C9hZD5SuDu3u/3YAdxdgX97ItUrrJC
         7dDqbCXtgLoc5f4vPT0VRaV9ZZLTu4j29aFCQMOIt4K36aQfRzedVypHl7vW7glXjOys
         P+lV6apUMZnV5IDAoG9FzR7UjScaeBNdqk7vo=
X-Received: by 2002:a17:906:1815:: with SMTP id v21mr25738574eje.376.1623193186096;
        Tue, 08 Jun 2021 15:59:46 -0700 (PDT)
X-Received: by 2002:a17:906:1815:: with SMTP id v21mr25738567eje.376.1623193185987;
 Tue, 08 Jun 2021 15:59:45 -0700 (PDT)
MIME-Version: 1.0
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Tue, 8 Jun 2021 15:59:35 -0700
Message-ID: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
Subject: bpf_fib_lookup support for firewall mark
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear BPF list,

I am new to eBPF so go easy on me.
It seems to me that currently eBPF has no support for route table
lookups including firewall marks. The bpf_fib_lookup structure itself
has no mark field as per
https://elixir.bootlin.com/linux/v5.10.28/source/include/uapi/linux/bpf.h#L4864

Additionally bpf_fib_lookup() function does not incorporate the
firewall mark in its route lookup. It explicitly sets it to 0 as per
https://elixir.bootlin.com/linux/v5.10.28/source/net/core/filter.c#L5329
along with other fields which are used during the regular routing
policy database lookup.

Thus lookups from within eBPF and outside of it result in different
outcomes if there are rules directing traffic based on fwmark.
Can you please advise what the rationale for this is or if there
anything that I might be missing.

Let me know if I can provide any further information.

Cheers,
Rumen Telbizov
