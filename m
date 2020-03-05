Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185EC17AE6E
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 19:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCESrR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 13:47:17 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com ([66.163.185.153]:40625
        "EHLO sonic305-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbgCESrR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Mar 2020 13:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583434035; bh=GcY1vK8yKtz85gn0IdfY2ICNUki/N1ewme/5hJvjsOw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=DN56SIMKyQ9w0Obi4fhbFjWzlj9+81cBRaGY11RdxX1AZp3RK/oD9ZJOhjqrWq19Vii1cVGxYAVzJCFBHY251UMe6qwHIiBRFwfkZcMGKWn4SiMcBajg2BAvs+wNuxLrBbR3+9jJ8BjxaU0kU0fbbd69Y4KdtErLw388/l5upzz3SpmVcruCW+Y8PsBeCSleWqrX3Fx7a7uH6nRqJiBDUnMNYZ+MGNkhWqXcnqeEksWErr5Z0FjLETJ1xb6PnE1ZFXXGtGK5tf+L4HRlkzbjMYjKBEigrpDxOCYce7j/iB4DXv7uDmIcfkggdqdISol2Xe3YgKT1wTjrhdF7fOMH3g==
X-YMail-OSG: x3ePi6wVM1lyyaPpn_rd_bDwmw38mdq7JnnVd_LCm5_IWrxPCc8o0GriRdTLtHO
 K9iuUoMrK9NnVXUCKfHD33qlt_idDY8Cn25ek8.zjy97N4e166vm9FFf.7XF8EAMfvhOxw3nzwxE
 g12hH0dJGgOlqx0kIk8BFfgcRQp9fD3uNDqDHzwdOk1JyRsrGQ6sCByCAX3hFcfrnM7T8j0ZSyUz
 kyZIzyTkcz77u1nV4X5if7cQDZ5XJcsyg3WUBwU8cqy9D0q8rmaj6tYhDWS9_4Ub.rB5FmFtefGs
 Fxm6SxSaGRwCcM23wIiU6ENzPkQlgUiiznXi66L.NJlcwd7pvrliwqV_m1yIW2rqOAD0a9flS87X
 IgeDzU05FvIWRg95GwP.z46BzKPmNIkATPn7U5N9LhiukPsKCQQETmuFzdHW0IC_g2dDRC5Ua8Xt
 cBQnHJDMVdKkcXPjXSgMC4tAfFj28aq6Koa9ta6oUfkg47QhKC80Zv01XYowfZ1HnjxnDAEU7VCg
 nklDmQs1wxSCvZvRF9nxcSbr1huUOaGaAHgJnrL6LdJlaVmyoECQOzTUsUiMHkm331q5RzqxVViI
 YSuId.neZbLwHKxoATXCib.XsZncxPLtx5oFFaBmel4XfipFNP0IBYqE190jYF_W2MOD0Zx4r4ya
 Ttv9D.NViWQVQZUJi4m9aM2Y_y7YokdsRG_eQHHYDFgHLXos9M5A.1n4zLej2ny3.7wHL3PnnVB9
 zNvZpSFhiLNCgyWN53YVK_9ZhCGCmfVNS9vz4e_q6NdQyfE1F8ZVBNlgdSxGT8yKMzu2hSsjWoJK
 x9K6GcA1xPc7cva7lNiUj55hwOjLrhR.qbtDbX7eWnsRh6.qdWpdQmylnkG6QsvUmPRMnq5.cfGE
 LrV9ulkD.BSk16BaPaFaTlrrgbMeUUtQZmSZsgnXKzC60n3ZuYdGg5oibCnhViwbVMqPxCk1eJc2
 3uFRqawrq39nz4y5.WcOkdhgWSj0OjsXQMO0CDS.3btkZonw.U8JTlN0IybIgrH.8lsu2OW1nKiv
 SQHJMTfvTfwBOOCwdFCn8Nd.Gmd5a8If6X4lUnme8JjyvPBW8xRTreImIWCQb8nZwSJQjkNGdLMw
 IDlIaLEHTqVhH_zggWGgnD7rPpxN5.20HBKNSO.zMJvTq4jgbvbFzWMjEIJj_K2xWAOAQ3ZmC0xn
 duYE9kK5Uf1nTufyguflvTxObP_2kr76MzRTax0El3JquNT8m1tu7ObuI_Z_yvxwDZ.TKk6bbAze
 TklLkOQn3l7lGSK8Ex2xBZ7lNBWnvOOthx7aXx36T4oQeTD_Hd2ocwWJ4N9VsC5o_bwoxvJJS0LN
 YvZERPHVYUyoenxXJo3ZLLAL3JBhK89ADWqS9IJU8ck_0nqAVMxm5KL_ZtnlJ.oJyddNRoEbWiiJ
 KxEcvBEmdhW50WGC_jzsY0XtqdRw3axg1j.qnBqQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Mar 2020 18:47:15 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 18dcc0ab0dcb8d07abc4d3534f6927eb;
          Thu, 05 Mar 2020 18:47:12 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_MODIFY_RETURN
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>
References: <20200304191853.1529-1-kpsingh@chromium.org>
 <20200304191853.1529-4-kpsingh@chromium.org>
 <CAEjxPJ4+aW5JVC9QjJywjNUS=+cVJeaWwRHLwOssLsZyhX3siw@mail.gmail.com>
 <20200305155421.GA209155@google.com>
 <d7615424-48cb-1131-3c5d-f2a0b4adfaf7@schaufler-ca.com>
 <CAEjxPJ7EQjq2J8AGn+b90=yMG9H5CaNErk1PqtTz8T3CwdAvJw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <2a46d961-5cb8-bfc1-9e42-26d8af97ae86@schaufler-ca.com>
Date:   Thu, 5 Mar 2020 10:47:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7EQjq2J8AGn+b90=yMG9H5CaNErk1PqtTz8T3CwdAvJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/5/2020 10:03 AM, Stephen Smalley wrote:
> On Thu, Mar 5, 2020 at 12:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> I believe that I have stated that order isn't my issue.
>> Go first, last or as specified in the lsm list, I really
>> don't care. We'll talk about what does matter in the KRSI
>> thread.
> Order matters when the security module logic (in this case, the BPF
> program) is loaded from userspace and
> the userspace process isn't already required to be fully privileged
> with respect to the in-kernel security modules.
> CAP_MAC_ADMIN was their (not unreasonable) attempt to check that
> requirement; it just doesn't happen to convey
> the same meaning for SELinux since SELinux predates the introduction
> of CAP_MAC_ADMIN (in Linux at least) and
> since SELinux was designed to confine even processes with capabilities.

If KRSI "needs" to go last, I'm fine with that. What I continue
to object to is making KRSI/BPF a special case in the code. It
doesn't need to be.
 

