Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092786D0C64
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjC3RMX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjC3RMU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:12:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8505B8E
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:12:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so79286778edb.6
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680196338;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TZY23mK2Ajl0OI8tKVeuE+qfhgCYDJPVUAsK2A6+Cm8=;
        b=PWW9YGkPJmQnoJ9+SUDHiO0WEM+C7Rt+wTAuNbipJMtvE/qbJqvdtfCLREnh7BUwND
         uZ9fnVxvUrC+yNMgjSzUk8SydESFOXpEb2EgLcvvwhD+k8ypcq2jrYZABpw9KDtbVb6s
         donTab1yAAjxczxm26rTHlaaBaZTKfqyd+Jv+Jh9iRf1IrniCXxUNGtVJEsmC5LuTI8T
         0GadpY0BowILyjGv+UDMT0fPteLbj2L9ZXnD48OGUxjV5PjBTQPKU1iOd7/8Qdny2YC6
         fPBaDQ/bCcKj8oKBIpWe/LevlVHUfoOFUwsLLq6XbeD0VE9zxFT8EzCT4jFqwJpLwqXD
         1gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196338;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZY23mK2Ajl0OI8tKVeuE+qfhgCYDJPVUAsK2A6+Cm8=;
        b=Pzo4no5CsPfTfSTTdz8JLYgph8SOvc/BWWoVJy2nAoy4C/gM6ONTcS4rWJwcCDAQjO
         H9RjaiZBd+Kij9H6J5+shQ++xtFDs6vO0g1obSp97N3T7hUNVjOaX6MYm5IRpi+VoaY+
         QPKWZ9nRXydBw7VWbvtD67Isn9EV9ukYXNTLa6a98HeCMrusmmi1810yLCSUw6Gtw2/P
         dGj1saGYHxAvpDfVV1W6p6bq2Nd9PD7M0yGQa+KoyLaP5fNiAOnEgPylWjpiPlnDcNJh
         3wKPo+4HwzhMz+SaScnWyrICoJ7IogaGu3A6JRQ3FdCcCqlXKAEdq5pHBqy7b1XvxNSr
         +IiA==
X-Gm-Message-State: AAQBX9eP8nu2RN8tMb7VKKsUgUR9qCQzgLMw0p4nj1DIvuIbuObeEGM7
        axDesJ/NjGNwfbDPBxorbvbvqZJcmkRLhmKNuXjIi7c4oGg=
X-Google-Smtp-Source: AKy350b424ByYis//gk920V+JwgEzZ62DiG0FRopvsj3oszPSVvwsC6n/Wq7N4FeuOax1Gby7ypLg5BUY27S0BHu3gc=
X-Received: by 2002:a17:906:5943:b0:931:8502:ad02 with SMTP id
 g3-20020a170906594300b009318502ad02mr11895938ejr.13.1680196337680; Thu, 30
 Mar 2023 10:12:17 -0700 (PDT)
MIME-Version: 1.0
From:   andrea terzolo <andreaterzolo3@gmail.com>
Date:   Thu, 30 Mar 2023 19:12:06 +0200
Message-ID: <CAGQdkDvyUu2ZDDdRmb4YhDzB96hS1NPW=ju=_Y_C+6nyA6xVGw@mail.gmail.com>
Subject: [QUESTION] usage of libbpf_probe_bpf_prog_type API
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all!

If I can I would like to ask one question about the
`libbpf_probe_bpf_prog_type` API. The idea is to use `fentry/fexit`
bpf progs only if they are available and fall back to simple `kprobes`
when they are not. Is there a way to probe `BPF_TRACE_FENTRY` support
with `libbpf` APIs? I was looking at `libbpf_probe_bpf_prog_type` API
but it seems to check the `prog_type` rather than the `attach_type`,
when I call it `libbpf_probe_bpf_prog_type(BPF_PROG_TYPE_TRACING,
NULL);` it returns `1` even if `fentry/fexit` progs are not supported
on my machine. Is there a way to probe this feature with other
`libbpf` APIs?

Thank you in advance for your time,
Andrea
