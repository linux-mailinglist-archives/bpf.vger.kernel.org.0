Return-Path: <bpf+bounces-20517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3483F57B
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 13:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3096282F1C
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B910E20B29;
	Sun, 28 Jan 2024 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U777hR+6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rcPDOnbH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B7219EA
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706444772; cv=fail; b=XQ1xKHWP9a9AsE3WdQFBPRoklhHl+DenHNjqbk83r33OdTIdTbLmDG+IWlh5HXxEFc9P7oFreVozz5uwAKrGu3TAmYyhIPgfQazTAolooty76PBFQ/i+hRxStwJbw3R09RfGOks56qE1cTY6zzO3nvgxUYYZVtCAFIB5gvEhxPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706444772; c=relaxed/simple;
	bh=hehMIdPw+zKGbXr+gAW64Yx/x0NPO6rGcLRSG1G5Rxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=kax03n12X4qXh8rgwbNGVB4glldwqhOsWdkIAfvQ5ykh5hYNbOX5seeiM5Wuy9L3y79oxrj5hF7RN6S/awVToO6YWG7g8zXDoCDJo5X+vgAIlT7Yprl/3zOac07V2SQDeTDhA/6WS+nAKZYtnqllntZ4N9WlEwGOj+bstnsIKzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U777hR+6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rcPDOnbH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40S5ZFXV021421;
	Sun, 28 Jan 2024 12:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=hOeMiuuKeiB+xPZwO7d5tvV4nxHQ+d5mqZjMNd508KI=;
 b=U777hR+6U4yPE/S9zZk3mUGWlojzdohEewnbkWKdppOXabLSRmZ0+kdSVZx8euzIhu6p
 QTHlfxXVbVRV5JSpcjoShCeZrh4Ijw8bdL0cDfEJrmvx3DUrLU02PczYGgtdOWVzZ7xU
 sF71LKzMzqnTAJplLFf1qRc3s2HuS/xuiVR+oQx1vnb+yOaOwuHCGuWuAhfPpH0WqkYh
 dQmCVn80xfSG3o7J4tadPi4N9sFgQLIvJM47ejZvVmuwPJXu/3vxkhGl9UmLrpL7jhvs
 mT3hVh7ERMQTbW+k01jSre1WgvRkCpN8woQGcv8C9NzBr71lOhE5XZWXcS1agU5sR6dC QA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ea116-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jan 2024 12:26:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40SBPfxv031555;
	Sun, 28 Jan 2024 12:26:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr94uxxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jan 2024 12:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmtRljdPgn3xW9m7O9SXvcNNK8UJ7xKejmVnWl56sFiUDa8zUz22c7YICEzZ8spWbL4qQWAwRFbXXL+mAhgtG/PuCWD8Lp7ZR9ZqBqMM60/9oF/Os8ap5kf5RW7wCl9sS7HEMeU1gAWLnLAFSlv2TyPFOkzykrA1rNOnhOm7wSbr3xJFoYd3H0DHmnIdbPqQtEenXYL8lDOXg8GiijmrfLa+UgGkOVqYt5/16+wwxpo1Ufn3L26pr19lxbYKg5MRSzunb9uvgh6DyH+X9z1KxzJhJ5Kd7GwaAJOLlz1JZ2CLc0PuWVV/eyUMWOBUcvCztN2nE+SMgnL8HuBWORHR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOeMiuuKeiB+xPZwO7d5tvV4nxHQ+d5mqZjMNd508KI=;
 b=ENSSVPUu+K1WdhgDEKgqrC945IkMM0BuUb2BJ0wzxly5xB/LvZA4ta63+Oio8nvtsVy5FFHb49B1bXmho6qO/UxvtS0L/E9zNKDfiGN+yxTegDRTBxm7DcvO1Ja8dVJbSKDL5ZoSAYELHyDKFd/jnvHl0ijeYc7jkJbxOCp8EYpo0C3OPUR1rWdoMLW47ygOA8D7yavjSjhMtCzBuZBfmO/vN/btL32zjZ+AO+fMeBecvFOO0TK4bfbAqhLcwJh+1kr9VyXkvuxQIOgTj0NH+s17mEVlDsrb+iI+gMqx9d7r62wvs5NrQlOiMcvQcKVTohugp9+8FR0AGectPzBmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOeMiuuKeiB+xPZwO7d5tvV4nxHQ+d5mqZjMNd508KI=;
 b=rcPDOnbHw1afE/uGTTBEHqs75p+M5dCsua9sBgjzOVtG/2wRu3tl5EHP2cuGxHgM+DXnnFoDZiQIWvdklCp7Vx8LPDPBZcsGVHGN6QMOCGPpDA6JEhUvYwUejJ4ldhnGhwFk7cvkwg1M/teWYW3v8hdvD2KnDMFwkAVKrVrlfX8=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 12:26:01 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 12:26:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com,
        Yonghong Song
 <yhs@meta.com>
Subject: Re: BPF selftests and strict aliasing
In-Reply-To: <b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev> (Yonghong Song's
	message of "Sat, 27 Jan 2024 18:05:15 -0800")
References: <87plxmsg37.fsf@oracle.com>
	<b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev>
Date: Sun, 28 Jan 2024 13:25:55 +0100
Message-ID: <87a5opskz0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 619450de-7da6-4976-56ea-08dc1ffc48a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KCLvPbbVGE0ukqjtXlgabAy6gtJ2uGXA1TcFs9/m41tZeuTPa07edAZ9LHNXtWtsHE0yywVp9pF9kvnjw0akgdfZAqMK1UpUN6DZf/IFDaR3MUV6ugMlhWrvvOEkXdxZtPwuGfdXU3cHBjLehTtrIKmQ2TBmB5qS3372mF356rCIolBntpOKlQBH39AnTuX889vrm7lck6sWW1k+hGTI0MLCkXb73oQTAF3UA4sDgTf7gqY2kqfo3RaVldX85eJFHCc3mBXl2wXcKiajCP5Mo8V3yR7Gwhdzm0pzJOKDjyvZSeWhv3GG8riZ6999xKrLiOEtSev2IgpNMC13ysEbyy6qrNS+fvV5K8nfLFy6+F1A29mgTPumGdMWtNrsbX8g2mLsHje6R5Jyuk0Ss5sp9Cph33SvFIfVf04Zr3PXdQElkdhcOcIuZfOP9RLZezqZCcKmn4zYokRKbii2UF9+IasOW+3wrj9JeLow44Gg8EZ/9R9HjQG/Ic6yG6ufBpx36jprdT3tiKXqHgcMtLNWlhLC5Cf7TaZHyCetNRbrPjoX4SaKNctyUHa8Y8hzcCkqsonylmJvybUoHNcydqTwGSDiZ6z3vfowxVEIgvG0URUXPPxqJ1FTQcmHTReoEaPD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66899024)(83380400001)(36756003)(54906003)(6916009)(316002)(66946007)(53546011)(66556008)(6506007)(86362001)(66476007)(8936002)(8676002)(6486002)(966005)(478600001)(6666004)(4326008)(26005)(2906002)(6512007)(2616005)(5660300002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ax/TcFOQFq291tspSSYebJeSIVYy5EcaG4cGS0umKjeEqh9gD4dJT7jjCsaS?=
 =?us-ascii?Q?/fhNRF0cEU/mh0NJoAIYVmER+p0LeYbtJg28bwfGDkzSluc3ol7FwyJxWcJ5?=
 =?us-ascii?Q?8RPiL8DX54IAxviFbM5NxiXNs1JqeKl+Piz6VYFsAmJiuQzKkX2dGlBvVLxz?=
 =?us-ascii?Q?s+ACSMoCpdsqqlmQ9BqTVjHLTXumwaO63pra08iNptVKhyAI7SDg8WuGrq+P?=
 =?us-ascii?Q?fgXA9ZXYwHANH1VwIQdMiKSCcqxNbxUD22GGJyPVdRZTE748my3LGXdO01U5?=
 =?us-ascii?Q?C2kkW/N/eIhpTBUDMWl8gTbYKNiqRNolcKloeNS2Nt8j8pFpL2wYQrHt3R4X?=
 =?us-ascii?Q?JlBvlaC09c2Ry1JeRWD/3eL/q4ImmJIsxgjmZKEVoTvpvQbs5UiMtNwMude1?=
 =?us-ascii?Q?iXRpBu6KV0vWDEvNU2vTXUA303UgagnLyWcbKXDlzPYRFZzpJrl8IKU8uPG5?=
 =?us-ascii?Q?YEEs24PFocFwA4yHIEft2hrtAn88+pGsfDIsa4FDdRfAZml0icF77xI1cZQJ?=
 =?us-ascii?Q?cW2g27VvCgfH5rmuLeVemSamvl7d95066vmJL18PBCWKeBPZC0XBn8Kxmow4?=
 =?us-ascii?Q?Tie5CqkT9vuQoJYPEIo4xJxmeS3GWRbtUgKGHf0GCji5Fa2TpWu12GVTtx6m?=
 =?us-ascii?Q?Esn3ZUFZW813JEW7v7cMS+ve6lHbEvNuKRHURKTjMCAewuWN8z/pORsJpfvQ?=
 =?us-ascii?Q?am0ST/+JsBnAS44BTdhPQhjDVj/aa8Rv0l7DsSWYHJThGSC6zu/CpgPM+f3N?=
 =?us-ascii?Q?77yr9r2hldnPRgAht6GXy3XmdmOl9+wMXNxUrZtwh19cyNw5foEW3rymMhqz?=
 =?us-ascii?Q?/8yzPfuwa5nJDjNNmSku5jMi5E1zXcJo7J9dXDbj90ap1PZYRUee1kk0nbs4?=
 =?us-ascii?Q?2alaRQoxOigUYlCHd0Zjq/eHh3eCweq+005MMnEDWnPq7G0+67xF0YxgLbr6?=
 =?us-ascii?Q?16pgAC2mKSJKDZpEhipq/RTQqH3pnHlveSNG6exzkqMmUVZZsP0pB3ySWZmW?=
 =?us-ascii?Q?e/65Omkuk72dCf808l51m61QgPmsDjNY/72J4NaLNhTKrD7Qq45GEM5Y3XOV?=
 =?us-ascii?Q?mcg1WMByF0qpKo8mmnNyGkYpFw1+nOYWngtKlVwsXHkuBTUW4bA+EuceSSHE?=
 =?us-ascii?Q?qHY/xa5ntVqzV6oLyx50F25ZiZyeWU9ad8afLS+SkN8kfs1I/iP+dOtHQOdF?=
 =?us-ascii?Q?gqIXgcoc9kmBKtGJ2RW3ycfyaLrqqsdPpDgJufV+/yqb9UJkQDf4yL5v6yKD?=
 =?us-ascii?Q?7jUdSW+aSqbGBcKzEtEJTY8kwlDaPKn6HQ1xIgWUF6W5bZ7bXs3Kn81Hm90o?=
 =?us-ascii?Q?EPjLW85UHHb366CGQd3kEbuhKv8nrhBmL0YbRfvfBu+oTDanfdsdDsivgQfb?=
 =?us-ascii?Q?MLJuAHpHCXrz0vQOQtcZT4E7hes3YS71WLlqrUnMo5CtS7GiGLMK+uxbPL1o?=
 =?us-ascii?Q?IknqkA8SARKSymUNPzOOT3glU1vls1HpQHvE++MGQRx6SlMsE6Vvpa+C1vv/?=
 =?us-ascii?Q?NwPDXEecp6CR8RDN4TYpfzG6hrlFj0VyeClEKkkjSmAEdKjc3idJFKJebqx5?=
 =?us-ascii?Q?jBA9Ya39wgAP17VMrYlZ0sdhO6oasQX5pYQvc5/76hzrjGEVXIEUywYSr2T3?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Wa5OT2DGe59pcO/lry2v2um1Tg6fWHRpSTr+CdUf5Oi2mxsw7j4gL0SfLxrfA0+3wxjc17UHnDPExTn5SJ6/yX76TiR0CZ4gm7HOvpFluUvoE8qOt6J4J6JXniYEwwMBlGFr90x4gJfZd2w/fvOTAjk5uQrDh3kdv8FK1AuGUW+8xPepMjK75FXo/POl7DmH6RrbD1L/LfPRvhJ1EhQssGO4eTBGDwQ8wbqssuLGotH2KhV5xPBeS3tP7u3egFDDzGly2kQ1vtLVYHH34BlhIHuUUkTsZwTZ9OGu0xiK4FtA4LrRpWN3SA36+LURb3Gqgzc1ifadDBFC24hjrwkyya/xcJ5RNDdl3+mk+ieylIse0PFyskukSP20y3/Q1RaBjLIG/cruwwXeL0gHyRLnOiMkm4X9UHGm63zPC+xxSrUSzW5Q1XzOROlccVmMu/ulpeHFKydcN4352eLjdPvseTKLkBYPEKzWnAUYGbFRrFdUsFmImgnPdm8c/bm75STXtxQpPIUT+rBu3lumYAgxJOPwUlTvpltbfmH+su5ebqe+1fbNzOyhiQnGSAcfpipisTFc/9SoIx4zZPgOrV2sdjpXKSZfgOXP+wNLnU2YKrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619450de-7da6-4976-56ea-08dc1ffc48a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 12:26:00.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVr7y4fzwWZB7R/W5PVwAf2iYV+e6IBJOh3Be6C3h8mDpNRre9gKl4/c6W+jomaJBtytJeSrTZfpOtK47fGA2EArSOpTb0Tp2inFaCn1/NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401280092
X-Proofpoint-ORIG-GUID: uiXleKKg4NU6THZs-7_jL7D6W7sW-doY
X-Proofpoint-GUID: uiXleKKg4NU6THZs-7_jL7D6W7sW-doY


> On 1/27/24 11:59 AM, Jose E. Marchesi wrote:
>> Hello.
>> The following BPF selftests perform type-punning:
>>
>>    progs/bind4_prog.c
>>    136 |         user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[0] << 0;
>>
>>    progs/bind6_prog.c
>>    149 |                 user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[0] << 0;
>>
>>    progs/dynptr_fail.c
>>    549 |         val = *(int *)&ptr;
>>
>>    progs/linked_list_fail.c
>>    318 |         return *(int *)&f->head;
>>    329 |         *(int *)&f->head = 0;
>>    338 |         f = bpf_obj_new(typeof(*f));
>>    341 |         return *(int *)&f->node2;
>>    349 |         f = bpf_obj_new(typeof(*f));
>>    352 |         *(int *)&f->node2 = 0;
>>
>>    progs/map_kptr_fail.c
>>     34 |         *(u32 *)&v->unref_ptr = 0;
>>
>>    progs/syscall.c
>>    172 |         attr->map_id = ((struct bpf_map *)&outer_array_map)->id;
>>
>>    progs/test_pkt_md_access.c
>>     13 |                 TYPE tmp = *(volatile TYPE *)&skb->FIELD;               \
>>
>>    progs/test_sk_lookup.c
>>     31 |         (((__u16 *)&(value))[LSE_INDEX((index), sizeof(value) / 2)])
>>    427 |         val_u32 = *(__u32 *)&ctx->remote_port;
>>
>>    progs/timer_crash.c
>>     38 |         *(void **)&value = (void *)0xdeadcaf3;
>>
>> This results in GCC warnings with -Wall but violating strict aliasing
>> may also result in the compiler incorrectly optimizing something.
>>
>> There are some alternatives to deal with this:
>>
>> a) To rewrite the tests to conform to strict aliasing rules.
>>
>> b) To build these tests using -fno-strict-aliasing to make sure the
>>     compiler will not rely on strict aliasing while optimizing.
>>
>> c) To add pragmas to these test files to avoid the warning:
>>     _Pragma("GCC diagnostic ignored \"-Wstrict-aliasing\"")
>>
>> I think b) is probably the best way to go, because it will avoid the
>> warnings, will void potential problems with optimizations triggered by
>> strict aliasing, and will not require to rewrite the tests.
>
> I tried with latest clang with -fstrict-aliasing:
>
> [~/work/bpf-next/tools/testing/selftests/bpf (master)]$ cat run.sh
> clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian
> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include \
>   -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/work/bpf-next/tools/include/uapi
>   -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include
>   -idirafter /home/yhs/work/llvm-project/llvm/build.19/install/lib/clang/19/include
>   -idirafter /usr/local/include -idirafter /usr/include   -Wno-compare-distinct-pointer-types
>   -DENABLE_ATOMICS_TESTS -O2 -fstrict-aliasing --target=bpf -c progs/bind4_prog.c -mcpu=v3
>   -o /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bind4_prog.bpf.o
> [~/work/bpf-next/tools/testing/selftests/bpf (master)]$ ./run.sh
> [~/work/bpf-next/tools/testing/selftests/bpf (master)]$
>
> I does not have compilation failure. I am wondering why -fstrict-aliasing won't have warning in clang side
> but have warning in gcc side.
> Your suggestion 'b' seems okay or we could even add -fno-strict-aliasing into common compilation flags,
> but I would like to understand more about -fstrict-aliasing difference between gcc and clang.

It may be that GCC is just better than clang detecting and reporting
strict aliasing rules violations.  Or it may be that clang doesn't
assume strict aliasing when optimizing with the specified level.

In any case:

  progs/bind4_progs.c
    type punning from __u32 to __u16.  These are not compatible types.

  progs/bind6
    type punning from __u32 to __u16.  These are not compatible types.

  progs/dynptr_fail.c
    type punning from struct bpf_dynptr to int.  These are not
    compatible types.

  progs/linked_list_fail.c
    type punning from struct bpf_list_head to int.  These are not
    compatible types.

  progs/map_kptr_fail.c
    type punning from struct prog_test_ref_kfunc to __u32.  These are
    not compatible types.

  ...

And so on.

>>
>> Provided [1] gets applied, I can prepare a patch that adds the following
>> to selftests/bpf/Makefile:
>>
>>    progs/bin4_prog.c-CFLAGS := -fno-strict-aliasing
>>    progs/bind6_prog.c-CFLAGS := -fno-strict-aliasing
>>    progs/dynptr_fail.cw-CFLAGS := -fno-strict-aliasing
>>    progs/linked_list_fail.c-CFLAGS := -fno-strict-aliasing
>>    progs/map_kptr_fail.c-CFLAGS := -fno-strict-aliasing
>>    progs/syscall.c-CFLAGS := -fno-strict-aliasing
>>    progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
>>    progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>>    progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
>>
>> [1] https://lore.kernel.org/bpf/20240127100702.21549-1-jose.marchesi@oracle.com/T/#u
>>

