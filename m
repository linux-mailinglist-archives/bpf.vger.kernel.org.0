Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB1667495
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 15:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjALOJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 09:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjALOIp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 09:08:45 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2109.outbound.protection.outlook.com [40.107.21.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1C5882D
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 06:05:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Edu3YTdFYhMkDe4Cmb4MBh+2SqFhfi7uhkXe2EKc6E5NNft/VCPcvbHShm6IMVlglCePDjTX1TVN9YNa4bryU5XriurMDfPJTOak5rO2vVULV1HXJlTCYUQZncsVHomE0EovXujVCev7rXLCLa92yG0zCMHjNAa2vx3OUj+NsejhAJfikdxLqLZMP79wxRJZOyNkzpRd7R+twTyhiKzQY7A4AYjGWTfx/kD33LPprDIWwbiHE1qyf9FgICelhY5q7vLLXYeG71JQ9UHWww83BtD/5C47S2s97GhAPEff5skarNUNqv69VgvYi4Fj6RT/cwdSiuh/gScQS9VSvJ3Wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO4IYpY8iBERtiNNf7re0M+IKWn+a4UwNLlo9FpXZLw=;
 b=JA4MB2DWn9CDuEKA4zi1Hzhj/Tz8eDgBMiNkv4W+EpNqFvkbmE1ArXa0unkePx8bRiu1Mp1PpJ/ywTyzl+488flf+EpARfwm1ADuBMlQmKxh2f8nDYUyHh6wUAm63DcW6B1IZP7MCjCXVU9vStAsIRA4y67RcxpquYSRR6OaFhw/R3QRHR7aH+0uscV8TzZ2vaPvVcoiDYfORalqyHX6jcM1B31TgeOBvpoi+8QJPZITMnHq2lI0jgHNwREG7g4RxGH4LPDPRg6Anv7DRduhjeMfH/8NypMqqL4fUc/It51gA9EOffizXXTKyuNSKOUzJadWMpi369cNaKavFvGDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aquasec.com; dmarc=pass action=none header.from=aquasec.com;
 dkim=pass header.d=aquasec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Aquasec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO4IYpY8iBERtiNNf7re0M+IKWn+a4UwNLlo9FpXZLw=;
 b=i3R27S+bHcG79vQwHYYXgUyhYUiyWcRsnVYF4qBk/Kev0Wq2ruJ9E72/HwReYI+LODb7KHe6yE5+l1rh5HpmapF39UwjogMKod99UMgqiBJ2cTAZ1q+KXjn+pU7/wJan+YLR2z8yLxOXwlrxT/Pnc8+Zh6VI3/lyH0bfGuRT//L5y0wEW2Nt/3PF88e/iWPV0vpKxgqwg3t/5QTu1Tvz1ZCgsPSPjIdsibifhTCDEimDAVJIyPyUkxMyN8LH1xfBoZhOeoyxNtUydhLU3WAXV5cHSLcae19SUxxyB5zpi3Am6SnvlHkDjm+KHC/yaGn0JtGE+sbyY/moprYC4cNf4g==
Received: from DU2PR03MB8006.eurprd03.prod.outlook.com (2603:10a6:10:2dd::12)
 by AM7PR03MB6232.eurprd03.prod.outlook.com (2603:10a6:20b:13b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 14:04:46 +0000
Received: from DU2PR03MB8006.eurprd03.prod.outlook.com
 ([fe80::fdf7:3aaa:ce1:5c70]) by DU2PR03MB8006.eurprd03.prod.outlook.com
 ([fe80::fdf7:3aaa:ce1:5c70%6]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 14:04:46 +0000
From:   Ori Glassman <ori.glassman@aquasec.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Potential write after free to a task local storage within an eBPF
 program
Thread-Topic: Potential write after free to a task local storage within an
 eBPF program
Thread-Index: AQHZJoyCvyij5YHkqk2wOGaZw/JGf66az02C
Date:   Thu, 12 Jan 2023 14:04:46 +0000
Message-ID: <DU2PR03MB80060A94A9078440548B901196FD9@DU2PR03MB8006.eurprd03.prod.outlook.com>
References: <DU2PR03MB8006816CEC3A464A3E94752E96FD9@DU2PR03MB8006.eurprd03.prod.outlook.com>
In-Reply-To: <DU2PR03MB8006816CEC3A464A3E94752E96FD9@DU2PR03MB8006.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_Enabled=True;MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_SiteId=bc034cf3-566b-41ca-9f24-5dc49474b05e;MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_SetDate=2023-01-12T14:04:46.588Z;MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_Name=All
 Employees
 (unrestricted);MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_ContentBits=0;MSIP_Label_218796d3-aea3-4b13-a12f-7c029d274f36_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aquasec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR03MB8006:EE_|AM7PR03MB6232:EE_
x-ms-office365-filtering-correlation-id: 44451cdb-7a1b-4b27-414d-08daf4a5f680
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CVq5ce3MYu0P42epv6Kx9E/AvydzjB12m6vANArDgpQzCrq73k6BlNKZ49Ea7HMJojwKRibm1XUbUUoPec63TXtunPHAqHwbtMn+2EUs/ywOpHuRT+p/zVl5SMMMs2uLNN7CWCc8/BbpwrFJmOP5APywBYlhC1R7thOsdPk7l2aZq9YC+zkQQsJn6Yq0npMHYiy65rswzCebv2czdlif68/UQVvjjs0fUq/RdhjaL/EUcsUvoRTtZZlsvw9LDmiaJJe0PpZTyXVKc1xNbbdNceeUDxx+x3n2JO3tBbCM1IlTfXLE/1BR0DdDr5cIAOp8gzKPQmQfiSa1yikyxQA36ktFv3+deN2TF0XnCTDQqKhLc+dteKkwyLgrw7YKcO//hh0t1ItQdzLnVBjSRrEmBsUBgnMr96jzhU3txLiR+v+RUWn1wT8S06EQkq4WGGaAOhTEaKQzWd5dzwdLlmrG7wiWulTeT8gE2sa2lWaEBVscENDf5Ri9fXPznJQ6fWOFAOhqorBHcy5w3FK3BGjYHlToTv0T11r2hGMcAMc6emJDSoy9gdygJCn7WKKz1RrQHzy1N7vW96oOVDkfFzZYqMmMXYtim2b0QKWeu6zeTw1F0xQmM/tw1O5nRf1NDPMhWz+1J6F7yrUlnhlyU2OszS5o7xTyft886aOYTJe0T2N4F/qWnJP9dvgfP3GA+dQ5GGuF+TfEgpkaHhgy6UXksQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8006.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(451199015)(2906002)(5660300002)(52536014)(8936002)(33656002)(26005)(186003)(9686003)(2940100002)(4744005)(41300700001)(44832011)(76116006)(55016003)(66946007)(71200400001)(91956017)(38070700005)(64756008)(66446008)(66556008)(66476007)(86362001)(6916009)(8676002)(38100700002)(7696005)(122000001)(83380400001)(478600001)(6506007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0R9mM5AwBsCTfd75RZyfF3zuDuJOGbvSSBmumdCKicU1gGzWtDRKsaLYam?=
 =?iso-8859-1?Q?GtzN3ha8LWn3T2qBm5FmhFfC87vkVP1L6lir9U2DodjdastK3vb00WfiFA?=
 =?iso-8859-1?Q?y3sMwEZhtAEoc2b9gPONnuqhoRI0E+IVH8ZK0lxjk6M35zPNWqgzLMLE71?=
 =?iso-8859-1?Q?/oN5x+yE/xuKh+LNWwOXn21tsdZ83P0WguOxvVG3v9SQmatzrbYterZm+j?=
 =?iso-8859-1?Q?6DN0MwiuJo1atBr5cvEcfKVy9D3IPBEv6bdPi55NKKq25E0FAYDnIF9EZ1?=
 =?iso-8859-1?Q?mMAqyuJe7/D0RFPWhTJksB5E8WzIX5QIv6bK/R23sJZXJFBR828zA3Uf6e?=
 =?iso-8859-1?Q?qc4ySaHJPfkE6iu7YOB2SUxmiMU9WGm+MAN5VYLR2F7zfFCF/kNe2Tq5J6?=
 =?iso-8859-1?Q?FflMkfNt+yv29aYdLlDjkYArzFhnMeNVofJuyj2aAZhgT1dsxEfPonVamf?=
 =?iso-8859-1?Q?ZGTL1DwMeIEfRlkmNiTWjfrWP6g+wsyNudDP5aTuAR6L1j3snVqgWdTPKy?=
 =?iso-8859-1?Q?4fQKhsHN9U0XoC+j/mgk3NrzSwVSkmpmsqWx5lbrq54Fzy29xTbH0vZ49J?=
 =?iso-8859-1?Q?oNXgoJAAsTIt4y4vPv9Qa4zhOd3pOFM2PH3e9xhKzXxwxqCyPJ+YaYOikN?=
 =?iso-8859-1?Q?3CbYWaZlwQsBiI9D9X+QimqdIpLuUmTajz+pj7dDcLoGqHbf+FkGmEumlw?=
 =?iso-8859-1?Q?3xHrfPR6E83wBxvccs9Rbhi9Z85zz5FWg06zp5dm9D58vRA7d9RgBm26SX?=
 =?iso-8859-1?Q?7ZjgFRx7lS9edqBiBGX+33X26qMjV1tzh/jZHh7w9Qm8Loydyid5k8R/EQ?=
 =?iso-8859-1?Q?0NPLfachtuM5Y0i7NNcLvVX9alOs5lzFsVWXBwKnOTQHzAKB9KgnEL2WYb?=
 =?iso-8859-1?Q?Ej7lK1MJhab1yKoDarBpYvhyaelvONxujy44708/VcNFWWBNNbwiYQ2geN?=
 =?iso-8859-1?Q?+3wdKqKB36I8LMszu6k6zofc4huxDzKUoRF/gqKg5OGWbfLSBPtddTsWE0?=
 =?iso-8859-1?Q?w7DL1jHIH7YlaOtK9nBRUP+Qy3sbPZAKIraL3ekhW9sGjDQSCW2O80OldS?=
 =?iso-8859-1?Q?DJ34oYT28Q4oDNA0RpOBaDZjm1nLrwmxgW9wz7CPYDVsQVkXIgSMq2MR3N?=
 =?iso-8859-1?Q?XfM4E8mQQQbeS+Ce7cCqRpj+vU0UK2b4HU3wXUclYMJpEp5solcOQe+lJQ?=
 =?iso-8859-1?Q?0vtooyvjbR3vAWL7G7X4UzKIUyxfOXmCDRDd6zb7/LNG3JJ966kS+oIvsi?=
 =?iso-8859-1?Q?xx+PkhKQXDO5ZnTeXiRspvDCFiTLeFnb9MAzmT33wrRSqtLdVri3wPVUCz?=
 =?iso-8859-1?Q?/rrfREyqe1shXyNixtoC1503het/wH2wtyT43IVJ5Msbq5e8VOtFmjiHOg?=
 =?iso-8859-1?Q?w1Svtau9AyN8YL+VaUlMarUjyx0BYbtWROhT5seD2Bh4j11AQlOcAkolxC?=
 =?iso-8859-1?Q?3q9mFjxdb1WkDNoVx7j1N6PatPIbtDKysZtcGGFW8xT+UEXKQNfaN21k34?=
 =?iso-8859-1?Q?9ZL491OUOu98G9HuGCtg9bjfVxENghz1rMvc5n8eU6J9cnS329izsHE2Pk?=
 =?iso-8859-1?Q?PwqhVfiXD7eoJmFcoBSPZhU03rJft7h9w1EnA7dkZOyoT0lj9AB5YQaCZi?=
 =?iso-8859-1?Q?LShqy0YKa4rzD+7Z3eh9FxJAQU8ipDY6gm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aquasec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8006.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44451cdb-7a1b-4b27-414d-08daf4a5f680
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 14:04:46.8103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc034cf3-566b-41ca-9f24-5dc49474b05e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnWL7HXb+M4CyQ8YiH/xCRtzXoDu5oOj0yAHtUKlR3klSywJ+uMEoMQV/CT38ifR+3SnaKaAD442dWZXzQj4wZnR0v04RTN70+iqKFJmEsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6232
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,=0A=
=0A=
I think I am able to write to an non allocated task local storage memory wi=
thin an eBPF program (raw_tracepoint program), could anyone confirm this is=
 really a bug, and that I'm not missing anything? Here's the code (thanks!)=
:=0A=
=0A=
----------------------------------------------------=0A=
long *ptr;=0A=
struct task_struct *task =3D bpf_get_current_task_btf();=0A=
ptr =3D bpf_task_storage_get(&map_a, task, 0,=A0(1ULL << 0)); // create if =
doesn't exist=0A=
if (ptr)=0A=
=A0 =A0 *ptr =3D 200;=0A=
=A0=0A=
int ret =3D bpf_task_storage_delete(&map_a, task);=0A=
if (ret !=3D 0)=0A=
=A0 =A0 return 0;=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=0A=
=A0if (ptr)=0A=
=A0 =A0 *ptr =3D 300; // writing to an un-mapped address=0A=
=0A=
const char fmt[] =3D "%ld";=0A=
bpf_trace_printk(fmt, sizeof(fmt), *ptr); // this prints 300=0A=
----------------------------------------------------=0A=
=0A=
My system is ('uname -a'): 'Linux ip-172-31-3-230 5.15.0-1027-aws #31-Ubunt=
u SMP Wed Nov 30 20:19:26 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux'=0A=
=0A=
Thanks,=0A=
Ori=
