Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7A5729B2
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 01:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiGLXM2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 19:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiGLXM2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 19:12:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF8B9B9C7;
        Tue, 12 Jul 2022 16:12:26 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26CLjbVL024477;
        Tue, 12 Jul 2022 16:12:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=Fsnb9nJ8Yl8OrihcBFv8j7BKgwVko4cBfe1W7T7dpsA=;
 b=AXLMfNjQwqvS/3pI5ggM8Sr6ofv8I2D/Z4soTvnxroVpAB9g1E9gNu6/+rEFGxgl+oML
 xp0UP5vU1Y07K+2wE8sOuK9zURYp6XTayrc/RlNfzY0oD4NeME3GROKpPxNC0i4UDYJk
 XWiXmvljVNZkVr4/q66ik4y5x/Q/aH7FLSc= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h9h5erdwg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzeL+z/tdT4sGu5t2GeAwLfoe4xo3Hwnuugf1NtFT1F6SKpwOwxW6a94SW7Ssj4GF0fcDDYRBRzGyUwFopfe6gP6ktIeigszndvV4015gljZ2PWQHw7yuPOE4br3COvCHNTCY5YVh9lD7YB/NYAnvT6r06QXmIsys6b1UUQSVu2bdfY3S78/CVPm6UO789vmziaI5uEFcPizGA2yr3EzMcPvvQCZTG+aoTbhJEXFNTONOCD8uiQVRI3S+3S7/SyQX+sneDgwwvMqJRzGY+UuJEOe694bXPKXOCVuskF84a7yJJZ92KFcvkAidN5McHN2gmdDbQO3JvhFLc4xKX5EsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fsnb9nJ8Yl8OrihcBFv8j7BKgwVko4cBfe1W7T7dpsA=;
 b=FzfSoaHBRx+A9oBxUCGMgGXESHpR2Nvc9vK4nTV0/dqUmFTveepzlOeDfIZPP2g6iNl9pyxeWpFnPn1Q3r85ZRq5T2pxU6EDJChmExEWT6eb/OLMp8CSVbAbN9wlux05Xe1aDBK+j+wyBMI72pa06sYEhX/E5zCm9VunSrNUrXLZkAhy6ryi4ahyH4L09t8IG3YQLNq+NDfK8M6R7JNF4sahG1RbgoBf0z+AbbVDATxt61NWePrXsGfY8o4gV59bCwJsryl4tkbHCuB0sHX1rCa9QTtfB7mGLNpk0c66pA9Aj/lK5G7zOwhg6Di1aohJHuLyzGDSwc3hNCRLxFTNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3768.namprd15.prod.outlook.com (2603:10b6:5:2b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 23:12:22 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 23:12:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Topic: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Index: AQHYklIC37qezjyxh0moueFgoO/pNa1zhdgAgAAO4YCAABD0AIAAC/MAgADwxACAAEM5AIAAKMMAgAAvboCABOqLgIAAGVQAgADeG4CAAEVBgA==
Date:   Tue, 12 Jul 2022 23:12:22 +0000
Message-ID: <6CB56563-29E2-4CE0-BF7B-360979E42429@fb.com>
References: <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
 <YsiupnNJ8WANZiIc@bombadil.infradead.org>
 <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
 <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
 <E23B6EB1-AFFA-4B65-963E-B44BA0F2142D@fb.com>
 <Ys3FvYnASr2v9iPc@bombadil.infradead.org>
In-Reply-To: <Ys3FvYnASr2v9iPc@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62ca44ee-cf4d-455f-5c58-08da645bf9c5
x-ms-traffictypediagnostic: DM6PR15MB3768:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1MwXfFmy3fOdPPf/oTAtxgiudS8h9dDrqQ8xkxB1EW/3I+Gn/8jZWBl9fzrO1PqHBN02s6U37euhrj6bENRl38CDn0DB71pPwIMAYOMP3XlzvKbQ65sEmX509ozfM8TW8gr0NaPOZBR4Q4j1DqTIufxyibgjQ/luFAVUprWh2MNFLLS8QvpXJBRuVUMPGP0of7snoTw18dQlIbfwV4Qg9p2PmsHrYZ44zPdlXw82bGdc6l/ZK9V22RqOGji1fhgk1njw/kQwQO0TKU9y36QJ6EtY/KP9yyn5jGwvzYLLxF2rnpUsoL/m3ad0p2qe+xiThzug8QMWWMwzA+ZCfWZAFv9Cz76QlnOimCYFdQaCvOtTAeEZ3pZuLfPI2vombOC+sQWHTRG+j9xpinaqjyo616/Krdp2kWKGMjxRW4eXM352ZnrU79+Sx4ZxNYW2ByTT9l1gk1SLe6XA8gaV1eQ2G3g65pU3/6FmhjuiUDipSWuT+11m8kOyyMPgiq/9TV+egNke+Lv+6cOqFVQjV9cn7Q9JVgegOEDsbOZa4gUBXeP2Dksc1FhVLVnJUpAnxPwIXQrIDFxwYgf/D5enESgcSpMBr9H8lk4iJS8IGz6r7/T8ohLVLg6y/AquurOEQGshQzRbCsBjjcHsiOejmgXTBea2zOkx5+XJGzbDmDaRGcDJ9DcqLtqFhprN1jR7Z4CraCwocUpak5f0g5eRgPHE+06rESi/5Lsp4Rrp7yYSLvW2sNzlz/If0CeUr5RpDul1mVCync5+PuSXyKhBscZPE/3VnPzAUPvrsrmEV7/LmWyDDRC7XJfbXxd2zjQPAYprPp5JniawtcpGpqnfxCYEesMWOszxIQISUfi+7pLnzrA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(66946007)(91956017)(4326008)(66446008)(8676002)(33656002)(2616005)(8936002)(66556008)(5660300002)(316002)(76116006)(6512007)(6916009)(54906003)(64756008)(7416002)(186003)(36756003)(66476007)(2906002)(83380400001)(86362001)(478600001)(122000001)(38100700002)(6486002)(53546011)(71200400001)(41300700001)(6506007)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r8s2JgPJECsdt26E2C85W+irzq6JPuNIyf7mlIHDQ154JS6lXCPiG67KuIQ9?=
 =?us-ascii?Q?TGNaREanTLjZ6Yncqo0kiymsTpPB7LzsDy5r2js3hHYEz9iQMdKpaUwYTtc1?=
 =?us-ascii?Q?hrFAaThDoWvTLuoP+1J++dVx6i15Wl/J/ortZtyoVfu80VleJ2qaFk3iHYGq?=
 =?us-ascii?Q?eUJVVF6N1/k5BdryFnhbruokF+FWeTFPv7gjcFvd3nMmP5OkEaPA6PhFpAIz?=
 =?us-ascii?Q?/1br+ycwtUbZtM1oToJRORnNV7j65M4nglX+8ZoydXn1lncbu3qEfKsFZmpi?=
 =?us-ascii?Q?dcRuXPuyGMOinOax/TE1rguOf3kcTiDF9YASXDhBSHkjL5eOnKSU1M82jRvP?=
 =?us-ascii?Q?yF31skyfNCxqEMtZys/CAgp4c1oeGoCVuNedauZWslBNJjYd1KCatouprQoJ?=
 =?us-ascii?Q?/nVvXw8FLrjOyNPjxXynYUveWipMVr+ExepXO6R3ndCAv7k0Nj94KB1hVPNf?=
 =?us-ascii?Q?RyeMe9x7XuIlaJ4iundSUPfgXWCZHFAv4tdVvG4tVX4KuWU8UjHqLirvYRF0?=
 =?us-ascii?Q?zrQUE1ACnTJbryOW+8nrnOydCs/jhkKSLvMUsDN1pdCl1j0Vu4G9UOjiD4mw?=
 =?us-ascii?Q?sJN3+PNmRFsqRiXF0gnMvvcvaMbct42QUVDFEQ8LkCvLuUKHtCycl6hUW3YU?=
 =?us-ascii?Q?+xhoiN6Mvm2hHa3uxjnBq7T+w0/Go8ir1eR0NN+t7FlxVHce9cBbuEk+kUBQ?=
 =?us-ascii?Q?MVAe/qef2uPbDzBCVyWxr8yLN1GJL9jlFvEJQBLoVLMrBgk50wsMbt34QBzu?=
 =?us-ascii?Q?/l8SqjWCrFAYfBJ3LNMS+X/eXVAJZzRrIuLmW3UGDUkHf61MqYQpSFsRQkEF?=
 =?us-ascii?Q?esMFgpqjU5jCRmBeh84tEXzy6vkMAb4YRQCdzzhuK+kQRKw7IqGzcssIRcGY?=
 =?us-ascii?Q?SsAD15oZ3evuEDFkSJ6oFRDY5H9KH7Bgn9F2C8ZdBixuWleSlz0msFfe51y9?=
 =?us-ascii?Q?1s89T9iclqVV3HSrUeCc1kgkOhkftRUDnHdyvgQ6ZagRw4OmhYPmFmk4QNN7?=
 =?us-ascii?Q?ECDV8EXPMB3V8+s327U+624d8Qga3wBVNuDFGjI9aibyf0LSEBIcShmrVqr/?=
 =?us-ascii?Q?dwUQs15xM4PFIpDI4cjAqsjrZsBuV7H6c+btkLWNXNKorvOxmQiaiLXlaCBW?=
 =?us-ascii?Q?eCZx9qRDPD7C5q3bR+NH4tBmbo7/vwMQScwdV2J6k8JsRJFSDf73tGgOrxOH?=
 =?us-ascii?Q?06q+reTrLaA5PlipuKE1fpjmoJkZ9a5Nm0DOrzqTpf8uaEFL6H/3Axqu2O0e?=
 =?us-ascii?Q?eXb9wh/XlK+5U+nbo2HlwT4uHaB102rpTohEMIaOioL1+888rmz1yahkyOLr?=
 =?us-ascii?Q?MFeb9e8aJ520T1QfFMzrmn4KsY74yrOkpwyrEoien+rjltic60xSjV58D4k2?=
 =?us-ascii?Q?7ga4jFqYki2S/6+fjZYzrnGbTSurwdSKIgIBavNIoUMAgPoTX4qM/gRgCPoJ?=
 =?us-ascii?Q?aMGFaYwZglmi1YMTebcFlepzKTA9UnQPpZ0sIgy7sJV3Uykcj+2+Kve1EMoT?=
 =?us-ascii?Q?nEzkPO0WTp9/E6wuuZgdscoxJgzsZCqG4XuyuYMS1raOf7BSA0O15iAMIxWn?=
 =?us-ascii?Q?vgQLMy8iw8xCXP1/YQ0sY/luMd/wgAh+kLhlPZOlACDU5VGol+a2WD6vLkw+?=
 =?us-ascii?Q?lxgQOlVLb97U8b9J/Sh5jso=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D126FD71BEC36C4AAF4D102BB6388E4D@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ca44ee-cf4d-455f-5c58-08da645bf9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 23:12:22.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZAruDSayssIS41rlwMgC8VVmGT39N9M85uf0d2KHE0pUSPACDNHbft2hz8ADP42ChaxfkuW4gBn4Piv0IoLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3768
X-Proofpoint-ORIG-GUID: eBW_Yv-RTPKNXcN3PRe8979G26Jymurf
X-Proofpoint-GUID: eBW_Yv-RTPKNXcN3PRe8979G26Jymurf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_12,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 12, 2022, at 12:04 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Tue, Jul 12, 2022 at 05:49:32AM +0000, Song Liu wrote:
>>> On Jul 11, 2022, at 9:18 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>> 
>>> I believe you are mentioning requiring text_poke() because the way
>>> eBPF code uses the module_alloc() is different. Correct me if I'm
>>> wrong, but from what I gather is you use the text_poke_copy() as the data
>>> is already RO+X, contrary module_alloc() use cases. You do this since your
>>> bpf_prog_pack_alloc() calls set_memory_ro() and set_memory_x() after
>>> module_alloc() and before you can use this memory. This is a different type
>>> of allocator. And, again please correct me if I'm wrong but now you want to
>>> share *one* 2 MiB huge-page for multiple BPF programs to help with the
>>> impact of TLB misses.
>> 
>> Yes, sharing 1x 2MiB huge page is the main reason to require text_poke. 
>> OTOH, 2MiB huge pages without sharing is not really useful. Both kprobe
>> and ftrace only uses a fraction of a 4kB page. Most BPF programs and 
>> modules cannot use 2MiB either. Therefore, vmalloc_rw_exec() doesn't add
>> much value on top of current module_alloc(). 
> 
> Thanks for the clarification.
> 
>>> A vmalloc_ro_exec() by definition would imply a text_poke().
>>> 
>>> Can kprobes, ftrace and modules use it too? It would be nice
>>> so to not have to deal with the loose semantics on the user to
>>> have to use set_vm_flush_reset_perms() on ro+x later, but
>>> I think this can be addressed separately on a case by case basis.
>> 
>> I am pretty confident that kprobe and ftrace can share huge pages with 
>> BPF programs.
> 
> Then wonderful, we know where to go in terms of a new API then as it
> can be shared in the future for sure and there are gains.
> 
>> I haven't looked into all the details with modules, but 
>> given CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, I think it is also 
>> possible.
> 
> Sure.
> 
>> Once this is done, a regular system (without huge BPF program or huge
>> modules) will just use 1x 2MB page for text from module, ftrace, kprobe, 
>> and bpf programs. 
> 
> That would be nice, if possible, however modules will require likely its
> own thing, on my system I see about 57 MiB used on coresize alone.
> 
> lsmod | grep -v Module | cut -f1 -d ' ' | \
> 	xargs sudo modinfo | grep filename | \
> 	grep -o '/.*' | xargs stat -c "%s - %n" | \
> 	awk 'BEGIN {sum=0} {sum+=$1} END {print sum}'
> 60001272
> 
> And so perhaps we need such a pool size to be configurable.
> 
>>> But a vmalloc_ro_exec() with a respective free can remove the
>>> requirement to do set_vm_flush_reset_perms().
>> 
>> Removing the requirement to set_vm_flush_reset_perms() is the other
>> reason to go directly to vmalloc_ro_exec(). 
> 
> Yes fantastic.
> 
>> My current version looks like this:
>> 
>> void *vmalloc_exec(unsigned long size);
>> void vfree_exec(void *ptr, unsigned int size);
>> 
>> ro is eliminated as there is no rw version of the API. 
> 
> Alright.
> 
> I am not sure if 2 MiB will suffice given what I mentioned above, and
> what to do to ensure this grows at a reasonable pace. Then, at least for
> usage for all architectures since not all will support text_poke() we
> will want to consider a way to make it easy to users to use non huge
> page fallbacks, but that would be up to those users, so we can wait for
> that.

We are not limited to 2MiB total. The logic is like: 

1. Anything bigger than 2MiB gets its own allocation.
2. We maintain a list of 2MiB pages, and bitmaps showing which parts of 
   these pages are in use. 
3. For objects smaller than 2MiB, we will try to fit it in one of these
   pages. 
   3. a) If there isn't a page with big enough continuous free space, we
        will allocate a new 2MiB page. 

(For system with n NUMA nodes, multiple 2MiB above by n). 

So, if we have 100 kernel modules using 1MiB each, they will share 50x
2MiB pages. 

Thanks,
Song
