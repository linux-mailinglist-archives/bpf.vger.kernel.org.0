Return-Path: <bpf+bounces-17468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09FB80DF5D
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 00:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264F628266D
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 23:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5C556747;
	Mon, 11 Dec 2023 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uminho365.onmicrosoft.com header.i=@uminho365.onmicrosoft.com header.b="NBqaE5pM"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93B9A
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 15:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQU0TaAuOyRoemHefWPut8bMb6CNJIfeV6hlkKd5BFjwyg4TIw7m4zrNwqiJTucJXxGY80YftDTvHQ++RtKnR4Fzaxu0TLMuExx1uJfuBfhhx+SfLeBJPK0BDu1E8nC9nS6/wYnG414F0WyXuf65KeLCKX6VqMovY3zHPryTMPApJEDtrlze/b1RLGfCxeyiWoA3mxEL5zEeITUXx/wM3h1XK7OwNWUS5zBLHSEDZpxUyZJzLfcdqsO/g3UMqBlrRre76G1QImgf0jTK0U9X0uZXVgC1jTAETho8xLzx4T093DHgQrUwF9hkQitmE/70JjffVCQQVTVWFhGpdem6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNrXER+j/K5WNMx0FM5cYb9u1N/1vmw/cLtlDvuThs0=;
 b=aUWlA83RXH+rkUpFTQvn6UG5FMHmrrABCc0YZLWcijzQPsstN1NPc1Ek/pbL5a85kajjqjV8R37ERI26a6HS/WbAglZ9eA/RqjEnrPYqpG/09G08UzkBL6LAP+Xagid2EmcXf1SwEsXi0v/DZYEmDoDdVEYGmh+FkW6MXBf90itUj5lpF5zpqglz25zmQBC/LJqucjWFnk/RvPMPU/eG1vakG0xox+/MJ7JyaBoq5e2rbzdw1lVbJAcfQSB6FvyOGwXR/qZXZk7mijJ7r58sCwF5NmAVHIekmbOxW9gbceLkadsxd/hbGkrp/gLEvyiH8x/o7oXp6q3mdqH15fup6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alunos.uminho.pt; dmarc=pass action=none
 header.from=alunos.uminho.pt; dkim=pass header.d=alunos.uminho.pt; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uminho365.onmicrosoft.com; s=selector2-uminho365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNrXER+j/K5WNMx0FM5cYb9u1N/1vmw/cLtlDvuThs0=;
 b=NBqaE5pMlUiTemBYJS6JTTnHLxG/f/xwhWh4pPh+nACW+yqEmcIdu7PW6hLHC5KClYOKkaVKt3LkB8zoS1CkzG373mxF7rDSJd3CgoVpSWhtLgLPTVPOlcFG62LtPWrOWMGVxUvBOwZdYYRF3khMRXzD/OrZXN1M7Fl+CUPWnc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alunos.uminho.pt;
Received: from PA4PR04MB7678.eurprd04.prod.outlook.com (2603:10a6:102:ec::18)
 by AS8PR04MB8531.eurprd04.prod.outlook.com (2603:10a6:20b:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 23:18:28 +0000
Received: from PA4PR04MB7678.eurprd04.prod.outlook.com
 ([fe80::d7b2:a00f:bfee:de4d]) by PA4PR04MB7678.eurprd04.prod.outlook.com
 ([fe80::d7b2:a00f:bfee:de4d%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 23:18:28 +0000
Date: Mon, 11 Dec 2023 23:18:25 +0000
From: Bruno Dias da =?utf-8?B?R2nDo28=?= <a96544@alunos.uminho.pt>
To: bpf@vger.kernel.org
Subject: libbpf/BPF-CORE kprobe arguments
Message-ID: <ZXeYweVsl9BOvfyZ@alunos.uminho.pt>
Mail-Followup-To: bpf@vger.kernel.org
Content-Type: text/plain; charset=utf-8
Content-Description: msg
Content-Disposition: inline
X-ClientProxiedBy: MR1P264CA0074.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::29) To PA4PR04MB7678.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7678:EE_|AS8PR04MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6834d60c-5e20-4326-f19d-08dbfa9f7b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/PpNR58WMXua82NWCgKndokh2A9AuaBL1RPwmEaAD5nPq1Lio770yvdwdYsZ6ShYCbhgSIMUtDRXiIm/J36j6HUYlfK28z7nQai92DWmpXatFKZD5aUNDqA7G6ZOuMulmtaHbN9dBZLGSkFJepesTq4F+/T88zDhp7yXn+QD0TP9s7ilkWpjfIFfpZvQC5cgjlfiX0UFvxMMcQoE9H6XBfjFegQa4uIm2qXchXgPh4+wmM4WyQi4McthiNNGQZfZj9aHod1ENl74boXHGgx8Hxv+Ao3iA6rRnIUtE3czzmN37pFVRzAr04+CyTe6ltK2gB3CKQL3hkJo2aofiK5jJTyOQNOCW6gXskklOfUeEFCB3C4CdWhKC5rNi53pv+E6Aesg9ibaAOSZtI5geOO/tQfSWE2Eda0ZqtPcWGAxFqtSY+Z+mZGgEPgIJEjzHUfLspHHWpq8lJguQ5vHDBZl0AWAsZhW5Zz2H2Luus93VwwECvYsa8Xa4SmQQZluhp0BR5+keFkC68uNfT1QAFVVVIcGyT8bT4JUmlUdCDdRGRLTI8lmDUf5DjxCFAKh45JE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7678.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6486002)(478600001)(2616005)(6512007)(6666004)(52116002)(6506007)(3480700007)(38100700002)(86362001)(85182001)(85202003)(41300700001)(5660300002)(6916009)(66476007)(66556008)(2906002)(83380400001)(66946007)(316002)(786003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmNpcWYyekcvY3FuVkRjVFU3eXBLV1R4UjB1cUszdUp6UFI2cGF2RmZIYm1T?=
 =?utf-8?B?WHdEZ2pXSHVTS2k0QWpHN2dDSDlOUk05ZThPODJmSm5oTmtFRFFwa3pzb2Ns?=
 =?utf-8?B?QitlSXJ0eEFpTkY0WndDYnd0RStTRHNmbkErR205OVVyOXpGVjIrdlQ4UWlx?=
 =?utf-8?B?bUdhSEJxa2U4VzA5UFdQQjFXM2ZhTHZDYWJnd0s5QlplZkRLRWlDOVJlMGJT?=
 =?utf-8?B?UElqR2NFdGZNRWY0MDZLTjluTTN0aWVQU2ZBUXdCWktqbi9uNlpZcmUwTHFu?=
 =?utf-8?B?V1l5SW8wT3kzVXF1Umloazk0MjU1WHAzTitVT1A0UDdRN2lNcUxxR3VsRnZU?=
 =?utf-8?B?enhJRGRPQWlidzBkWlo1WGJSQkdFSFN3azhZU3Mrem1tWXAyYUVCRVEwZWhT?=
 =?utf-8?B?LzA5VXYyeFBUbGxxTUIxZTdHWHE3Ri9yNWgrRWNmSThuNSt5M1FkanNOdmNV?=
 =?utf-8?B?UVB6TmFaQnFJWU1lYTN0ak11MXhlbC93V0NuYk9Gc1VLQ24xYmVtaUp5WEdF?=
 =?utf-8?B?aDh1QjF0RVZxbUloYjJaYThlYm1WT211dmR5VU5JcFFjRzQyb0RQYWh2SDR1?=
 =?utf-8?B?Q1IwYlZLVE5lcC9JVnJBOVZTVHh0NjZIMmV6QkloNFdIVzQ5b2o0VHhZUUJq?=
 =?utf-8?B?bDNkMU1HaGpZWEZMNi9Lc3NkWHE2SlhITTlWRjBPais3eG1meGswWDNqbG1n?=
 =?utf-8?B?Vk5UdXhUWkpSWFdZNHV4Z0w1OGtnUU0vY0thK29EbXhhT2IwaFpjcWtINXNB?=
 =?utf-8?B?N0MvWEY2WXlTdHJuZHlSbXBnVWRzYXRSK0xpVERkY2J0Zi9xNGc1aTlzbVhJ?=
 =?utf-8?B?Q3VFYTVNREp5bFBlSWY4NnZVME9hOEJJRVVZaGw1YTdwZ3plWTh0VmplMzBQ?=
 =?utf-8?B?U2VTTWsybCswYnVXYXd3dEp0cUNWWXloT1RCZkU4QlFLekQ2cDFwampVNmZM?=
 =?utf-8?B?eWtBOXVHZEN2eWlsdDRHZnpTR01OSFRDeVNXSDE0anpKeFBtMmFkOWxGRmEy?=
 =?utf-8?B?YWZVVnVLZFdPc2p4c2ZrY0NmdVo4enBiN01HT0hPMUk2YjIweXRqMlJNREdL?=
 =?utf-8?B?YWhtZXNkVkgxK1hENExNSVUvTFJldG1pbUZRc0QvUWJTQ3lRVVA5N3ZHeE44?=
 =?utf-8?B?K0RFZUpoRHZMUHFScTNCajQyUy9Kbzhsc0VzTVdwY3VEbG5vNjlyWEhwaXZs?=
 =?utf-8?B?WElrdVFzbGxuanYyTUZvT0dSNVpqNGlmaGYxeWlYSzVQMVh2aGRZUnVubzRw?=
 =?utf-8?B?WGdWVjlpbDVLNFhZejUwL3JtcTZxb1NLM1RvOHVOVllYUHRDTG9KT29TWEx4?=
 =?utf-8?B?a0I1VHNERmg1QjVRVS8rd3dQTmtEVnJYKzlEMFp2TW1VdGhsaXBkNjl4WWI3?=
 =?utf-8?B?OHI3bzJ3UkZxd24wN0ptMTE5SEF5NWIrUGN1MStrVzFrZlRQNkEzYWU0THVp?=
 =?utf-8?B?T2ljRmZwVlNaMDhtTm5yYnVrRUs2RW52a09yV1BmY0RldG5kWGlQMWpVM3J5?=
 =?utf-8?B?aVVTNFArWjRXcEJnRkxOSnZDSkQ5VUxjdHpxNjhWRlRQTUFwenRmME1RNEFa?=
 =?utf-8?B?L0tpTmZ2MklHaG44WGFmNDhiT1ZDdmtRTFI3TXFmVlVlK3dQU1p6ckdiZ2I2?=
 =?utf-8?B?eG15UXZYOXNaS1krWjdsL0k4UlBIUUQxZXAvZk4zVHdldmFNanRMN0hIMlcw?=
 =?utf-8?B?akxYays1VXphZmdvUEZNeUNsT0FsNk5jZzVpOHlMR3RuQ055S2YvM3VTRkJO?=
 =?utf-8?B?MU1iWm1HYWNiZm1XVUIxdllzSnlhaHAxTU1uaUNjTVBKUHJndm1tM1c2Qmkx?=
 =?utf-8?B?NG13QTVpZHBMSUl0ZXBqMkhWbk1CMFdSTTF1OEw3SjNkSnhZbk1YbzZkc2ZO?=
 =?utf-8?B?WDdoYVdZS2JlSkxHUklEMXBXZDNmYnJ3SURmQXA0VG9qVkMwRnVpU0hIOGw4?=
 =?utf-8?B?OC9PTHdJQWo5V1BSNkN0aXNQNGdXUHg3ZVg0U3dndnl6ZUdueDgzSTNNbWNi?=
 =?utf-8?B?aDJXeUZJWFUrS3FJcExBOERTZ0h3Z2htTEZRZjVReU42SzI5QTc1YjJHSFA2?=
 =?utf-8?B?RFd5N0VhaXJXcWNZSUpLaGdITzFuMnpEY0ZuRDFCQ3VLeE84SXRNYU9EQU5X?=
 =?utf-8?B?WkdvYzdTMmVRN0F5dlJIY2lqbFJwQlVOUXR0Ri9CMzNzSno3RjNKZTYrR1V3?=
 =?utf-8?Q?pZymIMfFSeD41X0F6abjYFSl1g6Iueuf45b/ItdimFrq?=
X-OriginatorOrg: alunos.uminho.pt
X-MS-Exchange-CrossTenant-Network-Message-Id: 6834d60c-5e20-4326-f19d-08dbfa9f7b95
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7678.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 23:18:28.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d05d4c80-da1e-4cd7-83a6-0d2094b20418
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCOZBTwGJM6v4mMokjrBZ6ArUU2i4LucioWy1z64ot5ZqovMtSJIKk/QXBtOa8V8Wm+LBG33USs0e8ffrxnWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8531

Hello,
I read in one of Andrii Nakryiko's blogs that this was the best place to
ask questions, sorry if not up to all standards.

I have been working on some bcc -> libbpf conversions and have halted
entirely when I reached working with kprobes.

In the following code I attempt to pass to user space the parameters
passed to the system call.

SEC("kprobe/__x64_sys_openat")
int BPF_KPROBE(kprobe__x64_sys_openat, int dfd, const char * path,
	       int flags, unsigned short mode)
{
	struct event *ev;
	ev = bpf_ringbuf_reserve(&rb, sizeof(*ev), 0);
	if (!ev) {
		return 1;
	}
	ev->pid = bpf_get_current_pid_tgid() >> 32;
	bpf_get_current_comm(&ev->comm, sizeof(ev->comm));
	ev->ts = bpf_ktime_get_ns();
	ev->dfd = dfd;
	ev->flags = flags;
	ev->mode = mode;
	bpf_probe_read_user_str(&ev->buffer,
			   sizeof(ev->buffer),
			   (void *)path);
	//bpf_printk("%d %d %s", ev->pid, ev->df, ev->buffer);
	bpf_ringbuf_submit(ev, 0);
	return 0;
}

However the output of this function (both printk and ringbuf) returns
values that are either close to 2^32, for ev->df, or downright 0, for
ev->buffer.

Note that this works very cleanly when attaching instead with
tracepoints but simply using tracepoints and not touching kprobes is not
really an alternative for what I want.

The result is also the same when using PT_REGS_PARM* or even explicit
ctx->di/ctx->si (etc etc);

So I wonder if the pt regs are actually being filled with wrong information,
if I have an incorrect way of accessing the values of the registers.
I did search online for information on these kinds of outputs but did
not find any solutions.

Again, sorry if there's clutter or if this message should not be sent
here.
-- 
Regards,
bdg

