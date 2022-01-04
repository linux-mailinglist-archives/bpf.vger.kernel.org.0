Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0034849B3
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 22:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiADVJy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 16:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiADVJy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 16:09:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCE4C061761
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 13:09:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id co15so32288698pjb.2
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=WcaUPZhd1VbdAnffeKIIhKScOMob5jIF2YkOTdvgsYo=;
        b=cFCeGJbF7EKqx5KGc+AxI6Vkaa0QjdDFE9qN9y+iC6lBvQYb95zAnLA0E38vzFp/bI
         4d3LTQpQbxkGjivLCELINEH+/jB6UEWFpfjldZbyYZKqlmfW8ypDy9J0lLQgMT5u+e6l
         +aaGyluPkzO482Z6rWqfVhjTpsaenHEnyPTyOIcCRZtWcqAa8CyXJ4wifw1y3Y8x8gsR
         198ICvfrsRfY9Lr0mACnZL//CMqLYOexXDWatFyUx1303j9ADdR7+5enTfgQtRIGCdKg
         DWyA50UXfYteEFv3qOBU0wX6lkmbClXL6+YPlxhxEYjc70/nmSLHWTY0tCgltBGUeX/f
         s3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=WcaUPZhd1VbdAnffeKIIhKScOMob5jIF2YkOTdvgsYo=;
        b=vLb5MUZ6r1ydnCdEIAR5knIePTI5j7JT1HoFE08HihtUGVSXXJmIvUgWA07xBv1XNJ
         Cpv6AZQ4noe7HK7IItXjJcK2ox7Up27m9r5daUQQc7EYvQz3VlArMfaV4f0+dHFA3FCt
         9EqIucL0xO0HfCrcnjIMqJbzlnJ7WdK3IV+/vP4mCRQkKTbEKQOqiFsDycUhN0zLdXjG
         pSYxz/wVEH5aGWQKMn1a0tqXSX5vAmxHfR0fWVyqf8n+EfNA8ffe+hBio5hv2u1fkIG7
         AsOilTeC2qX/llMCk2Dpsz2cgGLLMdgIyUNd1Q93FrDdJJuM1vCIffkAOKhZPmY4Mc5B
         DbUw==
X-Gm-Message-State: AOAM5324/Xy7DHKOLbpPxSUIUsgZ8S7NaJT8tf0vGLQJgOkCpJzBMJB3
        AaorXFA9j5ZveSjfWVWu9rRh1g4XcWg=
X-Google-Smtp-Source: ABdhPJzpOZdQAJgzizWLrdk80DeDwokk8REwgl5tqCd2FOcXAWlWpmuBPNqy34Cc2Bo7+IEmuM9eEA==
X-Received: by 2002:a17:902:d4c2:b0:149:c8d6:fb05 with SMTP id o2-20020a170902d4c200b00149c8d6fb05mr1448450plg.69.1641330593698;
        Tue, 04 Jan 2022 13:09:53 -0800 (PST)
Received: from localhost ([71.236.223.183])
        by smtp.gmail.com with ESMTPSA id z13sm237362pjq.0.2022.01.04.13.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 13:09:53 -0800 (PST)
Date:   Tue, 04 Jan 2022 13:09:52 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     His Shadow <shadowpilot34@gmail.com>, bpf@vger.kernel.org
Message-ID: <61d4b7a06ddea_460792081b@john.notmuch>
In-Reply-To: <CAK7W0xfX35NSKa_ExcpJkWoy1iX5mU7ogjHbr=T5sHJ9U+D0fQ@mail.gmail.com>
References: <CAK7W0xe9VVbyVykzTK8X8ieg4UgRJEtrvEyKgLjBO+iVFV41+A@mail.gmail.com>
 <YdOYhsVwGu1p/SSu@pop-os.localdomain>
 <CAK7W0xezGaA1TZcsxkt_hf+b0LU+396CmetejFBEXjqtvbmDkA@mail.gmail.com>
 <CAK7W0xfX35NSKa_ExcpJkWoy1iX5mU7ogjHbr=T5sHJ9U+D0fQ@mail.gmail.com>
Subject: RE: Fwd: eBPF sockhash datastructure and stream_parser/stream_verdict
 programs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

His Shadow wrote:
> Resending to the list, since gmail only picks first responder :(
> 
> >Are you saying the packets arrived before you put the socket into the sockmap?
> Yes, exactly!
> 
> Could you elaborate on how BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB would
> be helpful? I assume I need to set up a sockops program and record
> passive ends pointers to bpf_sock somewhere, then redirect from
> passive to passive or passive->active?

Correct. The common way to build a bpf proxy here is to add sockets
to a sock{hash|map} from the sockops program when the connection
is established. This avoids missing bytes as you've noticed.

Alternatively, you can put the known sockets in the map from user
space and then monitor for new sockets with some tuple/key and
insert them based on whatever policy decides sockets need to
be redirected.

> 
> 
> -- 
> HisShadow


