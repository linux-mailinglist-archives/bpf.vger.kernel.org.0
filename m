Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8751BDC92
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 14:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgD2Mpf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 08:45:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:6136 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgD2Mpf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Apr 2020 08:45:35 -0400
IronPort-SDR: 1OezuQSc8ZwhraGcaEcqlM7mIBvmFim4CGTL58y89AdYxDtLL3UVA0ZdTHGiN9JmZRA4gMsyFU
 HP+Y/49bBBOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 05:45:34 -0700
IronPort-SDR: CL29WUCbjn5FcsVFr1fS28Pwm2obiJuMImQGbVTjP7oNiaqPdpx7vQFKe2pvYHDsPMz2Lg+lH3
 jmCKh0+BvscA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="405028365"
Received: from amasrati-mobl1.ger.corp.intel.com (HELO [10.214.197.183]) ([10.214.197.183])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2020 05:45:28 -0700
Subject: Re: [PATCH bpf-next v9 0/8] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
 <0165887d-e9d0-c03e-18b9-72e74a0cbd59@linux.intel.com>
 <CACYkzJ6XyHqr1W=LWV-5Z0txFBtvPCwRY-kczphy+pS7PEitqQ@mail.gmail.com>
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
Message-ID: <b5652508-f727-b936-79b5-f8da658395f5@linux.intel.com>
Date:   Wed, 29 Apr 2020 15:45:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACYkzJ6XyHqr1W=LWV-5Z0txFBtvPCwRY-kczphy+pS7PEitqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 29/04/2020 15:34, KP Singh wrote:
> Thanks for reporting this! Can you share your Kconfig please?

This is what I originally started with
https://raw.githubusercontent.com/clearlinux-pkgs/linux-mainline/master/config

but I also tried your _LSM_ settings found in this
https://lore.kernel.org/bpf/20200402040357.GA217889@google.com/

-- Regards, Mikko
