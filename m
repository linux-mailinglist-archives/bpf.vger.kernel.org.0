Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096B01C0CC4
	for <lists+bpf@lfdr.de>; Fri,  1 May 2020 05:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgEADqq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 23:46:46 -0400
Received: from namei.org ([65.99.196.166]:56338 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgEADqq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 23:46:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0413kPI7029780;
        Fri, 1 May 2020 03:46:25 GMT
Date:   Fri, 1 May 2020 13:46:25 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mikko Ylinen <mikko.ylinen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf] security: Fix the default value of fs_context_parse_param
 hook
In-Reply-To: <20200430155240.68748-1-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2005011345380.29679@namei.org>
References: <20200430155240.68748-1-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 30 Apr 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 

Applied to:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-v5.7


-- 
James Morris
<jmorris@namei.org>

