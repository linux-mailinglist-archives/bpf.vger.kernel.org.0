Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3B4D3B2C
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfJKIbV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 04:31:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44620 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfJKIbV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 04:31:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id q12so6401007lfc.11
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=6OWPz9ueix2moqA6r0VBUVutb5y1zP0l1Jijpy0Ekfw=;
        b=eKhWAAHSuQJtgu/EFjgVJ2HRtib4XSRrU0tGiwQaieGOgXFSKe707UJw7HE9xXmqPE
         20IbGYrRQWL5UmezTw9ElsfantvVR1IZ2W9w6MXlGo0cgMIAcIi+tKqhi5HTYLLDqXHs
         lFhwwYWHff5a2QCcZCrjGH+wzTxjwTvNv0rY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=6OWPz9ueix2moqA6r0VBUVutb5y1zP0l1Jijpy0Ekfw=;
        b=YnbxNRweHJZiuvpJ3oZOPhgJKYkFDyhTgS4+YULDDzKnoUK7ZH03Njz3kgEZP0pLF1
         RKTX6aqSbRY4GlUpKvgTAxufzLvCtlmVEkQNEh7+UQodklNPQUsEQ8wcVi/FLbvi59Pc
         7oRdVtLbKbt+xnJljDHPln7e5IPCFMjXUgLuQg+IiwOxwFlOPptczA0TAUPYD3T6DP8r
         v/SqT3SvSqpdCzM2TBxcRqBvViwhlvxUGsZBaD0yNFBbAbkPEpspNStt/rb134Cm/kPo
         Y0uBuW/GSAvyDNYYxM2s0hRFFo0s47NCxtA8NkxKqcqK5+mc7L9+oCkc08C0mgrf+mUS
         2W2Q==
X-Gm-Message-State: APjAAAUO/yKSvVpp/EVu4gRgSeuOc/MwJXfD24j1/BT+5LZQm3pJ/q2K
        MKmkyi46LRTHEkpKsxZyAKMb4WVhxptdlA==
X-Google-Smtp-Source: APXvYqwU/lLDxY4MlMVBo0NiTzLx+4FHeIaSoEV+C2FbX/I8ARfXzpOFSIrPAQLhrj5ej0YGP85HNg==
X-Received: by 2002:ac2:5486:: with SMTP id t6mr8700768lfk.183.1570782678811;
        Fri, 11 Oct 2019 01:31:18 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id i142sm1890402lfi.5.2019.10.11.01.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:31:18 -0700 (PDT)
References: <20191010181750.5964-1-jakub@cloudflare.com> <20191010233840.GA20202@pc-63.home>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v2 0/2] Atomic flow dissector updates
In-reply-to: <20191010233840.GA20202@pc-63.home>
Date:   Fri, 11 Oct 2019 10:31:17 +0200
Message-ID: <87imov1y5m.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 11, 2019 at 01:38 AM CEST, Daniel Borkmann wrote:
> On Thu, Oct 10, 2019 at 08:17:48PM +0200, Jakub Sitnicki wrote:
>> This patch set changes how bpf(BPF_PROG_ATTACH) operates on flow dissector
>> hook when there is already a program attached. After this change the user
>> is allowed to update the program in a single syscall. Please see the first
>> patch for rationale.
>> 
>> v1 -> v2:
>> 
>> - Don't use CHECK macro which expects BPF program run duration, which we
>>   don't track in attach/detach tests. Suggested by Stanislav Fomichev.
>> 
>> - Test re-attaching flow dissector in both root and non-root network
>>   namespace. Suggested by Stanislav Fomichev.
>> 
>> 
>> Jakub Sitnicki (2):
>>   flow_dissector: Allow updating the flow dissector program atomically
>>   selftests/bpf: Check that flow dissector can be re-attached
>> 
>>  net/core/flow_dissector.c                     |  10 +-
>>  .../bpf/prog_tests/flow_dissector_reattach.c  | 127 ++++++++++++++++++
>>  2 files changed, 134 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
>
> This needs a new rebase, doesn't apply cleanly. Please carry on Martin
> and Stanislav's tags. Thanks!

Rebased and posted v3. Thanks to Martin and Stanislav for reviewing it.

-Jakub
