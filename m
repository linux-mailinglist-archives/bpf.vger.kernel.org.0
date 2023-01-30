Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71460681999
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 19:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjA3SsH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 13:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbjA3SsE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 13:48:04 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2108.outbound.protection.outlook.com [40.107.22.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221C13DCA
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/Y5YyNoVpG5gEnZeEdaoszLzhSp0wTTwQqgx/7g4vFRdX7837gIrOe5hJvsNUe9N7D7vaPV9zUNC8xuAcJnEtufPkLKLkafWNDxCMeR6Btfg5l52wpJmsxMv00KVKcCWZ58dy84rQZ3JMPI18esId8O1ZGF2zvD2CGSeoBbh+ZDgUA4eS64gIU8DiPRSCs8tJhWuMisjcz3vyhfHVP6ZjnOhiGi5FwhM5y+BQODDZwdhjc2dJoPfnYphsOhAMQ52mGaJokbr4Wd76ykTLJkHcOgYQCvHrAmQZYNXN1zlPDcBKlLj4iNdso6XNCdm0Ps5Esjt4D/YZ1/vAuZN4Ql0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSZQLqdrqNrli22V0WPhNfRlS988hXCgsLtt1AhRT9I=;
 b=mui7BkCsFUvz4LMtlLRSLIjaBZUBylwIiZnfFNkSdhyln7+x5MdGwKq7l/R+N3jI8zwYIHqlXd/VY/WLS7sM9p0w7AHdXJVBmHyO5EQauq1NDTjE7Y0k41rp/jnkiKQi7eoz/dOyaucao+ULeLIAJtCkID1bPVZ5yy5KVrZGer9iv+R+cHS2kjkeytz3ZUyb2FuDLxHz8HoujsUL8axk28j+wIrVB4at1VtFFvbrJeqF6EWS3JM53AVn3RdRprLMkvwePWqSA1/0Jg6btl2bsX2WU4GmYPDLb2eBgBCzYGbM7a6rAyLdIEflF4gpSP/m2hC+qjWsLpgX36dm2F98uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aquasec.com; dmarc=pass action=none header.from=aquasec.com;
 dkim=pass header.d=aquasec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Aquasec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSZQLqdrqNrli22V0WPhNfRlS988hXCgsLtt1AhRT9I=;
 b=RBPyNQ5QeTgnFOpciSUGDs/PIYNb7TN4hCBzea9A75mzFDtG9etUokSvUnK1bZt1gS6VmoYKlNoiUrlaEo+cXgP3dGoWMpN3HICmZtYS9qLNpIwymFO9QyCs3zo2yKcyEA6I8l7IMDG2+9r9Ndw+bxd45Rn7fy4FYS87CJQ42H4cTLkCALu8w6MLw+fcB6UxUEJE+NoYZPe2zLhE8otaW1kIbebBK7ZLCJVxmnwgJoxE0MDJOrt9PZj2tei4AM69sopL5g9Q8pzjwZYkOVR1p74u+8CZnAMI00De9TwnHJtS73G9jnXRECY7FnHixemrktFkZsI0T7GOtlW1eHc9MQ==
Received: from DU2PR03MB8006.eurprd03.prod.outlook.com (2603:10a6:10:2dd::12)
 by AM9PR03MB7819.eurprd03.prod.outlook.com (2603:10a6:20b:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 18:47:54 +0000
Received: from DU2PR03MB8006.eurprd03.prod.outlook.com
 ([fe80::fdf7:3aaa:ce1:5c70]) by DU2PR03MB8006.eurprd03.prod.outlook.com
 ([fe80::fdf7:3aaa:ce1:5c70%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 18:47:54 +0000
From:   Ori Glassman <ori.glassman@aquasec.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
CC:     KP Singh <kpsingh@chromium.org>
Subject: Re: Interruptable eBPF programs
Thread-Topic: Interruptable eBPF programs
Thread-Index: AQHZNKPbJ+BoxRCd90i1jYKvXFr/B663HuaAgAALn4CAAB9CTIAAAxsI
Date:   Mon, 30 Jan 2023 18:47:54 +0000
Message-ID: <DU2PR03MB800662EF7057E230662B34B196D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
References: <DU2PR03MB8006D93D98BD58AFF9657F3F96D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
 <23537684-afd1-e31d-741e-acaf8a201156@iogearbox.net>
 <CAADnVQLsXLGk5nOx75r-Os+S8wxKjboV3_SKqUm0QXTZXUeDSA@mail.gmail.com>
 <DU2PR03MB80069C24EAB81F7D72FD7EF196D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
In-Reply-To: <DU2PR03MB80069C24EAB81F7D72FD7EF196D39@DU2PR03MB8006.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_Enabled=True;MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_SiteId=bc034cf3-566b-41ca-9f24-5dc49474b05e;MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_SetDate=2023-01-30T18:47:53.696Z;MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_Name=All
 Employees
 (unrestricted);MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_ContentBits=0;MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aquasec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR03MB8006:EE_|AM9PR03MB7819:EE_
x-ms-office365-filtering-correlation-id: fcde394e-4f9a-4e6c-cc60-08db02f27f11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WOZqzeYdtNvh1zQrBq7oDfR5n+ULChBXteaDqfhSSB3z9XLrur7Mlb0TzkHg/1xKlnUrsBEHkfYGzyR2mG8WxjK4c9ZkhfoJbiG+g5QdhR9YPUDaI+fyUdXqGWsP8f7fQ8vWxV8tziocbvro3N1h+EhL3x6btdUpaxcSKIHl3M8g3LjwQaZOXSGndLCtarhohE/mx8m0zI7D6U/LdRAqpN/LWJsM5WN9pnAp6Jv9Acz3cqwCajELLFBG6VYmORm0Iv7YhL4piZxPq7oXdp/vSm8N6tTbyRaNh0/yWL5HVdcWmS8/Na99PxtUPnoiDotL66A4adVh1R6S7kcGcjgpKF+vYNsSWATczNypcg1Wz0jDLFjuuaz9sHo4RMXh3mbF9O1ETFE3P8BOoU6YEnX/pMHR7VxmQkeU9HKxXnLwLxq2XHJOhnrNMRgQZTXH0wZrOxniI1+IczCWttAkJijzwk9RWw4i4btsBnzUUsbE14Be9QQOMk1ElM33A+BaYOftVTepY1k/qQ9hAHMJr9mVtJBehgAY5/tTuC2eh76Ny+uRqnMl8tvgf0MiR8iIDfKNGsrnIg4VfbLYu2/SzvDBtXU/uspwNasAKq2wlO4FHqX3X5r6Q8IKlktR3C4kRCmv3xmXE9M0WTjDN4zYzu3gfNzH2yaV5YVzeBKE4UCK17G0Hros0WM/tNPjqO09chzPcSjLz5Os5GkOvYvgvihh6rZeH5NuJZbg19n5ZAyEQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8006.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(366004)(39850400004)(451199018)(186003)(71200400001)(7696005)(7116003)(41300700001)(83380400001)(966005)(9686003)(6506007)(53546011)(2940100002)(478600001)(26005)(66574015)(110136005)(66946007)(316002)(91956017)(66556008)(76116006)(3480700007)(122000001)(38100700002)(64756008)(66476007)(66446008)(8676002)(4326008)(5660300002)(55016003)(2906002)(86362001)(33656002)(38070700005)(52536014)(44832011)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TdFvWdhqvPiK1qgaASIajPOJhKZergRDf3j2ObLImhTMJZorFzUyHzrmT4?=
 =?iso-8859-1?Q?9XJrh74BFNyECNlgawxQlpjYJ/oO0she94qHqc89+1cm/lRp6QF2Kukemq?=
 =?iso-8859-1?Q?WjR/Qn2+4q8rAM4Sxa62bWA8A2SfMWqUMoBE3P0yTxkpehdXgX4cs6KqtL?=
 =?iso-8859-1?Q?sdtI+OGIHv7zGWTmtT/E2O50iwKf8nQIuwu5xqV+zJNJ3NZW7hLTYiYr3H?=
 =?iso-8859-1?Q?Px+C2MjBa5MGAgYFfZWAPH9YJIziosPIp4JaMOH2NQphtgKMMD8nenx3p/?=
 =?iso-8859-1?Q?E173oADhQCYVvRCZh9AEKc+qHCq2F4/8s0MoJ642+xukBJiyPKZta56n/i?=
 =?iso-8859-1?Q?Fql35oox07VSDoJAoYsUzqid+zcdaFqYMhEIGcnjyAPbw/2+wtld8SUM1h?=
 =?iso-8859-1?Q?cTSBNetlxT+2YPv0AiLiG/6atuM0Imu7o6AELU4IA4h5Rob1Ym0iqU+UUf?=
 =?iso-8859-1?Q?YQC0lQRksSL0Wh1qJkt6kd8tXCvRCtseNzPxJdO7tFmjmXHRP+RMcr3ODF?=
 =?iso-8859-1?Q?4PnzcUBUU5vuaWo/MbY3kXWWiGgpSpVQLPnm557T1rmyBq1Av09UbWCnYW?=
 =?iso-8859-1?Q?Ta/SAgd01zGjVsXlSrSb4TCEA7hTrDOXtElJfU/WFa4zfdoTgtOyyxbPx9?=
 =?iso-8859-1?Q?Z7V7F4r3al7C58IA+dJyV+BqXgetWlQSsFIUhGe9pi7N7hZu2fbXQR7/5R?=
 =?iso-8859-1?Q?HTrT8ikiecEmYVnpIUJ4fXqIFPN8wiPLFPXH8ftKTHfRXGs+dEMwiaYPDr?=
 =?iso-8859-1?Q?dx3T4cOj7A4WLNKiZEQo+L4TBHn5K4FR6kozA68N1HnDLFLQXuNxGMzNso?=
 =?iso-8859-1?Q?zh0cAclYt0DBC/20NxLu0M0t9DtfDrvv2xs73eLnALasTEs5ZLWy9woxan?=
 =?iso-8859-1?Q?rXFEUn7JsvnCrtdYaWQJVqc3Fx6jZd+9HIyiAdLCpIKZ9n1uncneyQkMde?=
 =?iso-8859-1?Q?FjVHTkU8aJWxL//qKsay+8aKxclu57HY/LWjLDsTYSKAws+mNvWUw+NYa+?=
 =?iso-8859-1?Q?cTyIWli8jjjZGpWZb16H2r4fNzRH8e2vbv44deBAjiiwbYIEyDz9KYggXf?=
 =?iso-8859-1?Q?4J0Ha2MLnQ+dv0V2zYsRWXSINpNhoZ1hjThsd/magvq63bUdWmVLcB0xUd?=
 =?iso-8859-1?Q?LQbcr5mhuG/OhKXKWphLNcrD/SG3lBq2PgXvFY2hjLPXP4otQqe7fAWygR?=
 =?iso-8859-1?Q?+mea2n1dTFTclWeGk6+TehnbzKsY/JCYEacWzJzz8Riyoi1jUpg6lOTZ4o?=
 =?iso-8859-1?Q?UnzMKO9I4Fh8gbYDTtmoCFxLHJu28dME1DPCyBGE5Mmu7RiPPbtWAKfy10?=
 =?iso-8859-1?Q?t3ppm8YebiZVnO4P1BVDpJ/RSKNGmirQOFDtjKKH82noMNC78efEXla7n9?=
 =?iso-8859-1?Q?iwcTIwJgunLbMzX6LhoJ3fisf1CH6sejiW8XOfW9HV37dotXe8VY5sm/qZ?=
 =?iso-8859-1?Q?oMm9TimP+vN01mEoNDHfp9uFWZi+alHiSAVpEtCG309gS5sIefLnI1gSHV?=
 =?iso-8859-1?Q?AAbAjd3QnJhWFdwF6yGEB7Hw9BiDo6Jr7UknCz+R21vyXIsfWDGFFOSaXY?=
 =?iso-8859-1?Q?y6u1gmKWEpNYBINwLcaxqocN0+BxSo0qkhcytWCvgoWwntGZ4lCTj2HHeI?=
 =?iso-8859-1?Q?zHVS55WnFke4pAR/qzpgTPSdm/J1zYeK6C?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aquasec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8006.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcde394e-4f9a-4e6c-cc60-08db02f27f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 18:47:54.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc034cf3-566b-41ca-9f24-5dc49474b05e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYOqgKCmSfqyJiVefxraICGrxUSUYZGgpnP67ik3H2QJhj29UFtNxkyutBd4+sPYXNJCCfFycY1jKjgK0S0pc93L6Ea4UgLbzsOWh3pBslA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=0A=
=0A=
=0A=
From: Ori Glassman <ori.glassman@aquasec.com>=0A=
Sent: Monday, January 30, 2023 8:45 PM=0A=
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>; Daniel Borkmann <dan=
iel@iogearbox.net>; bpf <bpf@vger.kernel.org>=0A=
Cc: KP Singh <kpsingh@chromium.org>=0A=
Subject: Re: Interruptable eBPF programs =0A=
=A0=0A=
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com> =0A=
> Sent: Monday, January 30, 2023 6:42 PM=0A=
> To: Daniel Borkmann <daniel@iogearbox.net>; bpf <bpf@vger.kernel.org>=0A=
> Cc: Ori Glassman <ori.glassman@aquasec.com>; security@kernel.org <securit=
y@kernel.org>; KP Singh <kpsingh@chromium.org>; Alexei Starovoitov <ast@ker=
nel.org>=0A=
> Subject: Re: Interruptable eBPF programs=0A=
=A0=0A=
> On Mon, Jan 30, 2023 at 8:01 AM Daniel Borkmann <daniel@iogearbox.net> wr=
ote:=0A=
> >=0A=
> > On 1/30/23 1:12 PM, Ori Glassman wrote:=0A=
> > > Hi everyone,=0A=
> > >=0A=
> > >=0A=
> > > Since the patch to disable process migration instead of disabling pre=
emption in eBPF programs, the latter are potentially susceptible to a resch=
edule mid-execution.=0A=
=0A=
=0A=
> Ori,=0A=
=0A=
> security@kernel alias is not the place to ask bpf related questions.=0A=
I apologise if it was confusing, I wasn't asking a question - rather raisin=
g a security concern of mine.=0A=
=0A=
> Yaniv, from your team, already brought it up here:=0A=
> https://lore.kernel.org/bpf/CAADnVQ++LzKt9Q-GtGXknVBqyMqY=3DvLJ3tR3NNGG3P=
66gvVCFQ@mail.gmail.com/=0A=
=0A=
> You cannot assume that different bpf progs attached to various=0A=
> events like tracepoints and lsm hooks won't overlap.=0A=
> It's a bug in your program. Nothing else.=0A=
How can one use bpf_task_storage_get() without the risk of getting corrupte=
d? Say there's a module that consists of 1 simple program, a single LSM hoo=
k on bprm_creds_for_exec, that uses a local task storage pinned map. =0A=
An attacker at some point in the future loads his tracepoint program, and m=
aliciously corrupts the local storage *while* the LSM hook is executing, no=
t after or before. What's the bug in the program that consists of the singl=
e LSM hook?=0A=
=0A=
> > Thanks for the report, Ori. We'll take a look and get back to you (also=
 Cc'ing KP and Alexei=0A=
> > for visibility in here).=0A=
> >=0A=
> > > bpf_perf_event_output helper in an eBPF program, can trigger irq_work=
->arch_irq_work_raise, which will send an ipi to the current CPU, which may=
 reschedule.=0A=
> > >=0A=
> > > By hooking a tracepoint such as sched_process_free that runs within a=
n interrupt context, an execution flow (of a certain CPU) like the followin=
g may occur:=0A=
> > > - start execution of lsm/<some_func> and executing bpf_perf_event_out=
put within the hook code=0A=
> > > - while executing bpf_perf_event_output, gets rescheduled and runs tp=
/sched_process_free=0A=
> > > - tp/sched_process_free returns and the CPU continues execution of ls=
m/<some_func>=0A=
> > >=0A=
> > > Using per-CPU data is a known issue in this kind of environment [1], =
this is also relevant for per-task local storage implemented in v5.11 [2].=
=0A=
> > >=0A=
> > > This is risky in general but becomes particularly dangerous when used=
 in LSM modules (such as apparmor), since the block/allow logic may rely on=
 shared storage that may be manipulated mid-execution from the interrupt co=
ntext and corrupt the decision of the module.=0A=
> > > A very un-harm example of such usage can be seen in bpf selftests [3]=
.=0A=
> > >=0A=
> > > This becomes a vulnerability if an LSM hook uses a pinned per-task lo=
cal storage - which is not expected to get corrupted mid execution, since a=
n attacker may load a program such as tp/sched_process_free, and bypass sil=
ently the LSM hook by corrupting the self-storage. The flaw is in the per-t=
ask local storage, which is not reliable.=0A=
> > >=0A=
> > > An example:=0A=
> > > ---------------------------------------------------------------------=
------=0A=
> > > // User loads the following program:=0A=
> > > SEC("lsm/bprm_creds_for_exec")=0A=
> > > int BPF_PROG(secure_exec, struct linux_binprm *bprm)=0A=
> > > {=0A=
> > > =A0 =A0 =A0int *secureexec;=0A=
> > > =A0 =A0 =A0secureexec =3D bpf_task_storage_get(&per_task_map, bpf_get=
_current_task_btf(), 0, BPF_LOCAL_STORAGE_GET_F_CREATE); // assume per_task=
_map is pinned=0A=
> > >=0A=
> > > =A0 =A0 =A0if (secureexec && STR_EQUALS(bprm->filename, "some_virus")=
) // assume this condition is fulfilled=0A=
> > > =A0 =A0 =A0 =A0 =A0*secureexec =3D 1;=0A=
> > >=0A=
> > > // secureexec is now 1=0A=
> > > =A0 =A0 =A0...=0A=
> > > =A0 =A0 =A0...=0A=
> > > =A0 =A0 =A0...=0A=
> > > =A0 =A0 =A0bpf_perf_event_output();=0A=
> > > =A0 =A0 =A0...=0A=
> > > =A0 =A0 =A0...=0A=
> > > =A0 =A0 =A0...=0A=
> > >=0A=
> > > =A0 =A0 =A0// secureexec is expected to be 1, but was changed from th=
e interrupted context and is now 0=0A=
> > > =A0 =A0 =A0bpf_bprm_opts_set(bprm, *secureexec);=0A=
> > >=0A=
> > > =A0 =A0 =A0// the binary "some_virus" will run without AT_SECURE=0A=
> > >=0A=
> > > =A0 =A0 =A0return 0;=0A=
> > > }=0A=
> > >=0A=
> > > // The attacker code:=0A=
> > > SEC("raw_tracepoint/sched_process_free")=0A=
> > > int tracepoint__sched_sched_process_free(struct bpf_raw_tracepoint_ar=
gs *ctx)=0A=
> > > {=0A=
> > > =A0 =A0 =A0int *secureexec;=0A=
> > > =A0 =A0 =A0secureexec =3D bpf_task_storage_get(&per_task_map, bpf_get=
_current_task_btf(), 0, BPF_LOCAL_STORAGE_GET_F_CREATE); // uses per_task_m=
ap pinned map that was defined in a different eBPF program=0A=
> > > =A0 =A0 =A0if (secureexec)=0A=
> > > =A0 =A0 =A0 =A0 =A0*secureexec =3D 0; // always turn off secureexec=
=0A=
> > >=0A=
> > > =A0 =A0 =A0return 0;=0A=
> > > }=0A=
=0A=
> These two programs access some task local storage.=0A=
I'm talking specifically when the programs are executed by the same task an=
d thus accessing the same local storage.=0A=
> This code racy regardless of preempt_disable vs migrate_disable.=0A=
> bpf_task_storage_get() of the same task can run on different cpus.=0A=
Not at the same time though, right? I'm not concerned about the cases where=
 the map is used in multiple programs - I'm concerned about the cases where=
 it's used locally in a single program, but gets corrupted in a timely mann=
er from the outside by an attacker.=0A=
=0A=
=0A=
> Whether trace_sched_process_free and security_bprm_creds_for_exec=0A=
> can happen on different cpus is kernel implementation detail.=0A=
=0A=
> There looks to be another bug in the above:=0A=
> doing bpf_get_current_task_btf from raw_tracepoint/sched_process_free=0A=
> will return task_struct of the worker thread.=0A=
> I don't think it's the one you want.=0A=
That's not what I observed - this is the output of bpf_trace_printk where t=
he execution of the LSM hook got interrupted mid-execution:=0A=
----=0A=
=A0chrony-onofflin-12460 =A0 [000] d.s.1 =A02258.804195: bpf_trace_printk: =
EXECUTION HIJACK(b=3D2257261931167) # this is from tp/sched_process_free=0A=
=A0chrony-onofflin-12460 =A0 [000] d...1 =A02258.804234: bpf_trace_printk: =
a=3D2257261896666. c=3D2257261971220 # from the lsm hook=0A=
-----=0A=
=0A=
=0A=
> Anyway, please start a clean thread at bpf@vger with bpf questions.=0A=
> Don't spam security@kernel.=0A=
=0A=
> -------------------------------------------------------------------------=
--=0A=
> > >=0A=
> > > Similarly, in cases where the LSM hook decides the return value (deny=
/allow) based on data from the local storage, this can also be altered by t=
he attacker, resulting in doing a malicious action that the LSM module shou=
ld normally block.=0A=
> > >=0A=
> > >=0A=
> > > I'd like to propose a tentative public disclosure date on 02/06/2023 =
12:00UTC.=0A=
=0A=
> You must be kidding.=0A=
=0A=
> > >=0A=
> > >=0A=
> > > [1] https://lwn.net/Articles/836503/=0A=
> > > [2] https://github.com/torvalds/linux/commit/4cf1bc1f10452065a29d576f=
c5693fc4fab5b919=0A=
> > > [3] https://elixir.bootlin.com/linux/latest/source/tools/testing/self=
tests/bpf/progs/bprm_opts.c#L24=0A=
> > >=0A=
> > >=0A=
> > > Thanks,=0A=
> > > Ori=0A=
> > >=0A=
> >=
