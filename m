Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F526945
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfEVRlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 13:41:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33679 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfEVRle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 13:41:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so3426079qtf.0
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=JJRKr+P1wfA+iLi/HQFVwk+HEdxOEhGs9WJgXP8XA50=;
        b=tqTDXKt2J4g9sYQGbh5Efv/MQlLP7kauUs9qV+1cJZ+nRNZQIo0ClxbzgsJuLLXOGk
         u+o+u7WiaFGEUsJ1uU/WZ4AX9vG344jBFd6Dh0CGgldIKjKbSdMMyBPO7mhl6pm100t9
         9S+EXMkd5yzJ/GDmgzDLaSbATIFV9BhZWq6CWeYo+Pu0Eyijzwg2VkR+EpEdDVBc5Sfg
         IqczZx9HM2mAf7IJMPLgVNE+/PS88gvt1pOJ603UIl6JNsmuQQp/nF0HQyuoyWKffsLy
         POB9Ui4Wl44OSNAzioPtC6FXGDetGCVf+0gAYFSAqF/1WC9lMem38dsjebsLXfQW4TRb
         yaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=JJRKr+P1wfA+iLi/HQFVwk+HEdxOEhGs9WJgXP8XA50=;
        b=rsnJOZObOTX1s5iiPfnI1CZ98eNSjCH/ST6lIUA/StybIxY2NMFspd/Gp3RGjFD+kc
         MWnyNPiKKZifgflpYlzEkVlPJg92BjLpqmNJEEWdRmac+xgPd6cNLWj8uRTtuE35XEY8
         TOIxhePqnLjbWBc3SfzgoXn5z0MboFf8YNsPUtrEZT3ovHwg4Dfz0Gdfvp/pv3Yo9iMx
         xGe+1YjgXvr2lN8LIdlM0bgIwx8uSXr4QPFCJx7wfP2B7IIHAPX0/byPy1yJC6JJamwf
         5WIFM6MuVBmve6TCp6PRjiNz91u7dgwn9wdw+N3mDOsVbP3aum5MlGVcCXt5uvULPC5v
         UYyQ==
X-Gm-Message-State: APjAAAUjcWmC69zAY1jxv905S9ucA/OfjPu8OL3/tQnzjzXSPqiNiYDG
        3Iw5FaNJO9wVLSKRelf4RVe7Lg==
X-Google-Smtp-Source: APXvYqxRfOLMPmCC+EuCbr7giLanjpdZIHDEmkpMwdlm2uvVsgLnfU57790Jg8WtVz04gcW1lXDhRg==
X-Received: by 2002:a05:6214:1047:: with SMTP id l7mr23580380qvr.183.1558546893955;
        Wed, 22 May 2019 10:41:33 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n22sm14567168qtb.56.2019.05.22.10.41.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 10:41:33 -0700 (PDT)
Date:   Wed, 22 May 2019 10:41:29 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     toke@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, magnus.karlsson@intel.com,
        bjorn.topel@intel.com, brouer@redhat.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] net: xdp: refactor the XDP_QUERY_PROG and
 XDP_QUERY_PROG_HW code
Message-ID: <20190522104129.57719c34@cakuba.netronome.com>
In-Reply-To: <20190522125353.6106-1-bjorn.topel@gmail.com>
References: <20190522125353.6106-1-bjorn.topel@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 May 2019 14:53:50 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> Shout out to all XDP driver hackers to check that the second patch
> doesn't break anything (especially Jakub). I've only been able to test
> on the Intel NICs.

Please test XDP offload on netdevsim, that's why we have it! :)
At the minimum please run tools/testing/selftests/bpf/test_offload.py

Now let me look at the code :)
