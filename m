Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A9516AB97
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2020 17:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBXQcU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Feb 2020 11:32:20 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:35182
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbgBXQcT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Feb 2020 11:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582561936; bh=jEdYHQfjEPk7Ub9OADMJTPn8R+rCgiglI9as12qrm30=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=hldjLpzcwV3BY5rdmK9yZGAUGjYZfPHOoZqCw0XhDH2KncJH37Pzx2ZkTM9xdDyqqc2V4yKvoMqO+uMmN+sfUeqP7LgmLWzyG846uxylbwkhY6evSGTY78wk791BzhlXAOFDCJSK5HCXOMP4MFCQWChWYbH/0pi+VTS7FPhGmp6AkSisZ7a4FJ4GBcyplhEgji0PaG98IiRd6lDZBz8aA1+/LEcM0Y7sKpuQISE4VaOD0MXOFCbmYhsN34YnSNRKJb/ei91iuZeNFve3Ub4GwLllYF6R8/HBTBI+5dwtPuCSYY9vwzjcJYK8FNGZzQrDY83c29Vrk45mJDgEN62qYg==
X-YMail-OSG: xJ_GdC4VM1l5kxxnBl0Lney9fsdvankXxCcLb.xZurXxr.JqokefUWynnPrVAXv
 vINYCXn0cjIA7RWXbbyOT7B_nIX1cJcSNP1Tl_Lfw_cB91PI1QwXFQ2SMliu3c51ureMiDH4h9Qy
 pK1w2dP2khkXe0rmFELSQ60X.HVogs2ujgrNlhaccLtNk9byg5losin4piTH5DxzygZGN6n7BtnV
 A98BE430XdsXDhAcEwTnpnCDaaachAqWRucc8mDZgd0._ZpjTp.wpJjZd_s7_yZdP1GSyG9Rzg8m
 BIoOC.YN9fEZnjccoakDuiejWMGFa93A7DYxKXHHvgupWqoAw8jfdxP_B5brxDylvsbT75AGDkEb
 UyAJveC.txTTWM8unBWaj7zrMRhDtuARwWR_0qj1WVjqgkCpzJaaOzp2sfBQmEllQxsHhGBdEp0.
 E5RSEsxTMHaOlD50GoCmmXtkwNou1CYMMFHx6j29h2oVC_obQAqxIH.Ur8Fkl_nD38URUI0VtPl8
 kMZVM6loixSvYLCxIO8l3b9bi4oBQLfjs38aWC0hMGF9gAhY83s5SOjfdoGfvzmbRkowT7jmWP96
 eqNw13NgJI8OATaz9uymx5E6mzhfqzG2V.bA91MbjNADBO20fS4w0M4ibLFOJif5YbtCqj9XrEPT
 0DeZ9W9qsr98U1Z5fS3Gj_TBCSH_vnq4sRdneC8hILGwVHFhns298ZNHABVs7ZwyfTUenDPWHPX6
 KyT_tpsO01_qHHHnw.D3k9n70urEAlEI8Nmj364y1Lw2nTCJ3t08s9i0t7JWyI.OXFnt37Af08t.
 6muE8JEHqztrhq1LZbgtxgb5KpZcn2k0hPOcbNFV.ut0CIyguBhyiqoEEP_OW7aE_Qdc6D9Ogh4B
 YcaxGlR7CDGILlhvxv1gdXCWPXPrTQmDbUtJYqpdnEEIfTrm4rrHS5nflqT2T0cYw4jF_hHTM4.D
 58gvUaVnj7uIKxEZH3jymzOaV2nmuXZOsvqVh4SYiOhhOyPjftBZcH2uJmxN6OOmc6c4I_WArFLW
 K596dICTfcvzw_wfanuhqHesRIDHt2GyKskkGWm9PHt2AEjz7UMOMPfMXlrDrs_EP4soPrRhCAZb
 jyXghOT00D0p.QkM9DDefp1V7OhaG90mHM_N_PP8zu9W5fTNbzS0xUk62WRUxAcMvE_dEVonwspV
 rUyF1ae9Pf4kbPLFCEmC6GHlv7.Wm.omK6K6rWY3YG_BYFHtHQ1k9k8eYTNQ7zDdwbHOBfSPaecl
 kOJBDjVuAfxjBhPqGxpxVfoN23nouMR9f9_LuvZ6Kb6pkyf1_6iP956ZcexfRUFjfoqcO6_OaQGx
 Zvt.yG8orifnc8h_C23cQvexXUVjThQWyyKx8pturKdHIwxHhYWkOI2Z63YSH1mwtU3H6IH0JPss
 kiek8TZ7EfF0lk5qxHKTNgaO_McVkyjmikQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Feb 2020 16:32:16 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c12ff2e79bd6414a6c59430047e9d2d0;
          Mon, 24 Feb 2020 16:32:11 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
 <202002211946.A23A987@keescook> <20200223220833.wdhonzvven7payaw@ast-mbp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <c5c67ece-e5c1-9e8f-3a2b-60d8d002c894@schaufler-ca.com>
Date:   Mon, 24 Feb 2020 08:32:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200223220833.wdhonzvven7payaw@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/23/2020 2:08 PM, Alexei Starovoitov wrote:
> On Fri, Feb 21, 2020 at 08:22:59PM -0800, Kees Cook wrote:
>> If I'm understanding this correctly, there are two issues:
>>
>> 1- BPF needs to be run last due to fexit trampolines (?)
> no.
> The placement of nop call can be anywhere.
> BPF trampoline is automagically converting nop call into a sequence
> of directly invoked BPF programs.
> No link list traversals and no indirect calls in run-time.

Then why the insistence that it be last?

>> 2- BPF hooks don't know what may be attached at any given time, so
>>    ALL LSM hooks need to be universally hooked. THIS turns out to crea=
te
>>    a measurable performance problem in that the cost of the indirect c=
all
>>    on the (mostly/usually) empty BPF policy is too high.
> also no.

Um, then why not use the infrastructure as is?

>> So, trying to avoid the indirect calls is, as you say, an optimization=
,
>> but it might be a needed one due to the other limitations.
> I'm convinced that avoiding the cost of retpoline in critical path is a=

> requirement for any new infrastructure in the kernel.

Sorry, I haven't gotten that memo.

> Not only for security, but for any new infra.

The LSM infrastructure ain't new.

> Networking stack converted all such places to conditional calls.
> In BPF land we converted indirect calls to direct jumps and direct call=
s.
> It took two years to do so. Adding new indirect calls is not an option.=

> I'm eagerly waiting for Peter's static_call patches to land to convert
> a lot more indirect calls. May be existing LSMs will take advantage
> of static_call patches too, but static_call is not an option for BPF.
> That's why we introduced BPF trampoline in the last kernel release.

Sorry, but I don't see how BPF is so overwhelmingly special.

>> b) Would there actually be a global benefit to using the static keys
>>    optimization for other LSMs?
> Yes. Just compiling with CONFIG_SECURITY adds "if (hlist_empty)" check
> for every hook.

Err, no, it doesn't. It does an hlish_for_each_entry(), which
may be the equivalent on an empty list, but let's not go around
spreading misinformation.

>  Some of those hooks are in critical path. This load+cmp
> can be avoided with static_key optimization. I think it's worth doing.

I admit to being unfamiliar with the static_key implementation,
but if it would work for a list of hooks rather than a singe hook,
I'm all ears.

>> If static keys are justified for KRSI
> I really like that KRSI costs absolutely zero when it's not enabled.

And I dislike that there's security module specific code in security.c,
security.h and/or lsm_hooks.h. KRSI *is not that special*.

> Attaching BPF prog to one hook preserves zero cost for all other hooks.=

> And when one hook is BPF powered it's using direct call instead of
> super expensive retpoline.

I'm not objecting to the good it does for KRSI.
I am *strongly* objecting to special casing KRSI.

> Overall this patch set looks good to me. There was a minor issue with p=
rog
> accounting. I expect only that bit to be fixed in v5.

