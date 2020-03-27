Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84D7194DF9
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 01:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgC0A1t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 20:27:49 -0400
Received: from namei.org ([65.99.196.166]:43818 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgC0A1t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 20:27:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02R0RFZ6017949;
        Fri, 27 Mar 2020 00:27:15 GMT
Date:   Fri, 27 Mar 2020 11:27:15 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 1/8] bpf: Introduce BPF_PROG_TYPE_LSM
In-Reply-To: <20200326142823.26277-2-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003271127001.17915@namei.org>
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-2-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 Mar 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 
> Introduce types and configs for bpf programs that can be attached to
> LSM hooks. The programs can be enabled by the config option
> CONFIG_BPF_LSM.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>
 

-- 
James Morris
<jmorris@namei.org>

