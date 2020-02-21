Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307A3168746
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgBUTLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 14:11:34 -0500
Received: from namei.org ([65.99.196.166]:47436 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgBUTLd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 14:11:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 01LJBQ3b020660;
        Fri, 21 Feb 2020 19:11:26 GMT
Date:   Sat, 22 Feb 2020 06:11:26 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 4/8] bpf: lsm: Add support for enabling/disabling
 BPF hooks
In-Reply-To: <bb32f155-5213-71df-c679-85c614c0ac26@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.2002220611100.20574@namei.org>
References: <20200220175250.10795-1-kpsingh@chromium.org> <20200220175250.10795-5-kpsingh@chromium.org> <bb32f155-5213-71df-c679-85c614c0ac26@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 21 Feb 2020, Casey Schaufler wrote:

> On 2/20/2020 9:52 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> 
> Again, sorry for trimming the CC list, but thunderbird ...

Fix your mail client, please.

-- 
James Morris
<jmorris@namei.org>

